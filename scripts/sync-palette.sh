#!/usr/bin/env bash
# ==============================================================================
# SYNC-PALETTE — Synchronize palette from the canonical static-noise source
#
# Usage:
#   ./scripts/sync-palette.sh
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEST_FILE="$REPO_ROOT/lua/static-noise/palette.lua"

LOCAL_SOURCE="$(cd "$REPO_ROOT/.." 2>/dev/null && pwd)/static-noise/dist/neovim/palette.lua"
REMOTE_URL="https://raw.githubusercontent.com/hcastillaq/static-noise/main/dist/neovim/palette.lua"

echo "⚡ Synchronizing Static Noise palette for Neovim..."

if [ -f "$LOCAL_SOURCE" ]; then
    echo "  → Sourcing from local static-noise repo: $LOCAL_SOURCE"
    cp "$LOCAL_SOURCE" "$DEST_FILE"
else
    echo "  → Local static-noise repo not found at expected path."
    echo "  → Fetching from remote: $REMOTE_URL"
    curl -fsSL "$REMOTE_URL" -o "$DEST_FILE"
fi

if [ ! -s "$DEST_FILE" ]; then
    echo "❌ Error: Failed to synchronize palette.lua (file is empty)"
    exit 1
fi

echo "✅ Successfully synchronized to: lua/static-noise/palette.lua"
