#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# Load Libraries
###############################################################################

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/yaml.sh"

###############################################################################
# Validation
###############################################################################

require_file "$LIBRARY_CONFIG_FILE"

require_file "${SCRIPT_DIR}/rename-all.sh"
require_file "${SCRIPT_DIR}/update-qrc.sh"
require_file "${SCRIPT_DIR}/update-qml-module.sh"

###############################################################################
# Configuration
###############################################################################

PLACEHOLDER="$(yaml_get "$LIBRARY_CONFIG_FILE" "template.placeholder")"

MODULE_NAME="$(yaml_get "$LIBRARY_CONFIG_FILE" "library.name")"

QML_URI="$(yaml_get "$LIBRARY_CONFIG_FILE" "qml.uri")"

QML_VERSION="$(yaml_get "$LIBRARY_CONFIG_FILE" "qml.version")"

###############################################################################
# Rename Paths
###############################################################################

RENAME_PATHS=(
    ".cmake.conf"
    "CMakeLists.txt"
    "README.md"

    "Module_resources.qrc"
    "Module_share_resources.qrc"

    "cmake"
    "config"
    "docs"
    "examples"
    "include"
    "qml"
    "scripts"
    "shaders"
    "src"
    "tests"
)

###############################################################################
# Remove .gitkeep
###############################################################################

info "Removing .gitkeep files..."

find "$ROOT_DIR" \
    -type f \
    -name ".gitkeep" \
    -delete

###############################################################################
# Rename Template
###############################################################################

info "Renaming template..."

"${SCRIPT_DIR}/rename-all.sh" \
    --current "$PLACEHOLDER" \
    --target "$MODULE_NAME" \
    --paths "${RENAME_PATHS[@]}"

###############################################################################
# Update Library QRC
###############################################################################

info "Updating resources..."

info "Updating library qrc..."

"${SCRIPT_DIR}/update-qrc.sh" \
    --module "$MODULE_NAME" \
    --dirs qml shaders \
    --qrc "${MODULE_NAME}_resources.qrc"

info "Updating share qrc..."

"${SCRIPT_DIR}/update-qrc.sh" \
    --module "$MODULE_NAME" \
    --dirs share \
    --qrc "${MODULE_NAME}_share_resources.qrc"

###############################################################################
# Update qmldir
###############################################################################

info "Updating QML module..."

"${SCRIPT_DIR}/update-qml-module.sh" \
    --dir qml \
    --module "$QML_URI" \
    --version "$QML_VERSION"

###############################################################################
# Done
###############################################################################

echo
info "Library prepared successfully."
