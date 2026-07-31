#!/usr/bin/env bash

###############################################################################
# yaml.sh
#
# Simple YAML reader.
#
# Supported:
#
#   section:
#     key: value
#
# Example:
#
#   library:
#     name: WeaQuick
#
# Usage:
#
#   yaml_get library.yaml library.name
#
###############################################################################

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

###############################################################################
# Public API
###############################################################################

yaml_get()
{
    local file="$1"
    local key="$2"

    require_file "$file"

    awk -v key="$key" '

    BEGIN {
        split(key, path, ".")

        section = path[1]
        name    = path[2]

        in_section = 0
    }

    /^[[:space:]]*#/ {
        next
    }

    /^[[:space:]]*$/ {
        next
    }

    /^[^[:space:]].*:[[:space:]]*$/ {

        current = $0

        sub(/:.*/, "", current)

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", current)

        in_section = (current == section)

        next
    }

    in_section {

        line = $0

        sub(/#.*/, "", line)

        gsub(/^[[:space:]]+/, "", line)

        split(line, kv, ":")

        k = kv[1]

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", k)

        if (k != name)
            next

        sub(/^[^:]+:[[:space:]]*/, "", line)

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)

        print line

        exit
    }

    ' "$file"
}
