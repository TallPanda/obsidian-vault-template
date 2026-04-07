#!/bin/bash
# Usage: bash "0 - Meta/Hooks/commit-vault.sh" "commit message"
# Run from anywhere — derives vault root relative to this script's location.
# Commits local work and pushes. Uses --force-with-lease for safety.
VAULT="$(cd "$(dirname "$0")/../.." && pwd)"
MESSAGE="${1:-Vault update}"

cd "$VAULT" || { echo "ERROR: vault not found at $VAULT"; exit 1; }

git add .
git diff --cached --quiet && echo "Nothing to commit." && exit 0

git commit -m "$MESSAGE"

BRANCH=$(git branch --show-current)
if ! git push --force-with-lease 2>&1; then
    echo "PUSH FAILED — remote may have commits not present locally."
    exit 1
fi
echo "Pushed to $BRANCH."
