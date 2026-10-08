#!/bin/sh

# Get NVIDIA libraries

URL="https://github.com/SveSop/nvidia-libs/releases/download/v1.0.2/nvidia-libs-v1.0.2.tar.xz"
ARCHIVE="$(basename "$URL")"   # nvidia-libs-v1.0.2.tar.xz
DEST_DIR="nvidia"

# Skip if destination already exists
if [[ -d "$DEST_DIR" ]]; then
  echo "Directory '$DEST_DIR' already exists. Skipping download and extraction."
  exit 0
elif [[ -e "$DEST_DIR" ]]; then
  echo "Path '$DEST_DIR' exists but is not a directory. Aborting." >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

# Download (curl preferred, fallback to wget)
if command -v curl >/dev/null 2>&1; then
  curl -L --fail -o "$ARCHIVE" "$URL"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$ARCHIVE" "$URL"
else
  echo "Error: need curl or wget installed." >&2
  exit 1
fi

# Extract into DEST_DIR
tar -xJf "$ARCHIVE" -C "$DEST_DIR"

# Remove the archive
rm -f "$ARCHIVE"

echo "Done. Extracted into ./$DEST_DIR"

# Build image
echo "Building docker image..."
sleep 1
docker compose build
sleep 1

# Final notes
echo "====================================================================================="
echo "Image is ready!"
echo
echo "Place your Windows Unreal Engine application in ./app directory and run the command:"
echo "sudo sh run.sh"
echo "You can also add extra start parameters for Unreal Engine by passing them to docker:"
echo "sudo sh run.sh -dx11 -Unattended"
echo
echo "As long as there is only one .exe file in Project/Binaries/Win64 directory"
echo "the run_app.sh script will detect it and run automatically."
echo "====================================================================================="
