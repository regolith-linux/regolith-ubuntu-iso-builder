#!/bin/bash

set -e                  # exit on error
set -o pipefail         # exit on pipeline error
set -u                  # treat unset variable as error
#set -x

REPO_ROOT="$(dirname "$(readlink -f "$0")")"

if [ -z "$1" ]; then
  echo "usage: build.sh <config-file-name>"
  exit 1
fi

# get config
CONFIG_FILE="$1"

if [ ! -f "$REPO_ROOT/$CONFIG_FILE" ]; then
  echo "error: $CONFIG_FILE not found"
  exit 1
fi
source $REPO_ROOT/$CONFIG_FILE

export TZ=America/New_York
export DEBIAN_FRONTEND=noninteractive

echo -e "\033[0;34m=====> installing prerequisite dependencies ...\033[0m"
if ! command -v sudo 2>&1 >/dev/null; then
  apt-get update
  apt-get install -y --no-install-recommends sudo lsb-release
else
  sudo apt-get update
  sudo apt-get install -y lsb-release
fi

# remove old builds before creating new ones
echo -e "\033[0;34m=====> cleaning up workspace for new build ...\033[0m"
sudo rm -rf "$REPO_ROOT/builds"
sudo rm -rf "$REPO_ROOT/scripts/chroot"
sudo rm -rf "$REPO_ROOT/scripts/image"

echo -e "\033[0;34m=====> generating default_config.sh ...\033[0m"
cat "$REPO_ROOT/configs/config.sh.tmpl" | envsubst | sudo tee "$REPO_ROOT/scripts/default_config.sh" >/dev/null

# run the main script and build the iso
echo -e "\033[0;34m=====> starting to build iso ...\033[0m"
$REPO_ROOT/scripts/build.sh -

echo -e "\033[0;34m=====> preparing iso and checksums ...\033[0m"

YYYYMMDD="$(date +%Y%m%d)"
OUTPUT_DIR="$REPO_ROOT/builds/$RELEASE_ARCH"
mkdir -p "$OUTPUT_DIR"

FNAME_PARTIAL=""
if [ "$RELEASE_CHANNEL" != "stable" ]; then
  FNAME_PARTIAL="-$RELEASE_CHANNEL.$YYYYMMDD" # $OUTPUT_SUFFIX"
fi
FNAME="regolith-$TARGET_DISTRO_VERSION-$PARENT_DISTRO_NAME-$PARENT_DISTRO_VERSION$FNAME_PARTIAL-$RELEASE_ARCH"

mv "$REPO_ROOT/scripts/${TARGET_NAME}.iso" "$OUTPUT_DIR/${FNAME}.iso"

# cd into output to so {FNAME}.sha256.txt only
# includes the filename and not the path to
# our file.
pushd $OUTPUT_DIR >/dev/null

md5sum "${FNAME}.iso" | tee "${FNAME}.md5sum"
sha256sum "${FNAME}.iso" | tee "${FNAME}.sha256sum"

popd >/dev/null
