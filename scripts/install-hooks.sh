#!/usr/bin/env bash
# install-hooks.sh - Installs repository git hooks

set -euo pipefail

# Helper for logging
log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

# Determine script directory and repository root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
GIT_DIR="$REPO_ROOT/.git"
HOOKS_SRC_DIR="$SCRIPT_DIR/git-hooks"
HOOKS_DEST_DIR="$GIT_DIR/hooks"

# 1. Validation
if [ ! -d "$GIT_DIR" ]; then
    log_error "The directory .git was not found at $REPO_ROOT. Is this a git repository?"
    exit 1
fi

if [ ! -d "$HOOKS_SRC_DIR" ]; then
    log_error "Source hook directory not found at $HOOKS_SRC_DIR"
    exit 1
fi

# Ensure hooks destination directory exists
mkdir -p "$HOOKS_DEST_DIR"

# 2. Installation
log_info "Installing Git hooks..."

# Copy pre-push hook
if [ -f "$HOOKS_SRC_DIR/pre-push" ]; then
    log_info "Copying pre-push hook to $HOOKS_DEST_DIR"
    cp "$HOOKS_SRC_DIR/pre-push" "$HOOKS_DEST_DIR/pre-push"
    chmod +x "$HOOKS_DEST_DIR/pre-push"
    log_info "pre-push hook installed successfully."
else
    log_error "pre-push hook template not found in $HOOKS_SRC_DIR"
    exit 1
fi

log_info "Git hooks installation complete."
exit 0
