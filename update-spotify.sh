#!/bin/bash
# @desc: Downloads and installs the latest spotify-qt AppImage, removing old versions
# @usage: install-spotify-qt.sh
# @tags: appimage, install, spotify-qt

STORAGE_DIR="$HOME/Documentos/AppImages"
BIN_DIR="$HOME/.bin"
REPO="kraxarn/spotify-qt"
EXE_NAME="spotify-qt"

mkdir -p "$STORAGE_DIR"
mkdir -p "$BIN_DIR"

echo "🔍 Looking for the latest spotify-qt release..."

ARCH=$(uname -m)
[[ "$ARCH" == "x86_64" ]] && GITHUB_ARCH="x86_64" || GITHUB_ARCH="aarch64"

RELEASE_DATA=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")
VERSION=$(echo "$RELEASE_DATA" | jq -r .tag_name)

if [ -z "$VERSION" ] || [ "$VERSION" == "null" ]; then
    echo "❌ Connection error or API rate limit reached."
    exit 1
fi

DOWNLOAD_URL=$(echo "$RELEASE_DATA" | jq -r --arg arch "$GITHUB_ARCH" \
    '.assets[] | select(.name | endswith(".AppImage")) | select(.name | contains($arch)) | .browser_download_url' \
    | head -n 1)

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    echo "❌ No AppImage found for architecture: $GITHUB_ARCH"
    echo "   Available assets:"
    echo "$RELEASE_DATA" | jq -r '.assets[].name'
    exit 1
fi

FILENAME=$(basename "$DOWNLOAD_URL")
FULL_PATH="$STORAGE_DIR/$FILENAME"

if [ -f "$FULL_PATH" ]; then
    echo "✅ You already have the latest version ($VERSION) in Documentos."
    exit 0
fi

echo "⬇ Downloading version $VERSION ($GITHUB_ARCH)..."
wget -q --show-progress -O "$FULL_PATH" "$DOWNLOAD_URL"

if [ $? -eq 0 ]; then
    chmod +x "$FULL_PATH"
    ln -sf "$FULL_PATH" "$BIN_DIR/$EXE_NAME"

    # Remove old versions
    find "$STORAGE_DIR" -maxdepth 1 -type f -name "*spotify-qt*.AppImage" ! -name "$FILENAME" -delete

    echo "✅ Process completed."
    echo "📦 File saved at: $FULL_PATH"
    echo "🔗 Symlink created at: $BIN_DIR/$EXE_NAME"
else
    echo "❌ Download failed."
    rm -f "$FULL_PATH"
    exit 1
fi
