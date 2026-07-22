#!/bin/bash
set -Eeuo pipefail

##########################################################################
# Usage:
# ./gall.sh [OPTIONS] [output_zip_name]
#
# Options:
#   -p PASSWORD               Set password for zip encryption. No password if omitted.
#   -u, --include-untracked    Include untracked new files.
#                              Default behavior: ONLY package tracked modified files.
#   -h, --help                 Show help message
#
# Examples:
# 1) Encrypted, only tracked files(default), auto name
# ./gall.sh -p Test@123
#
# 2) Include untracked files, custom archive name, no encryption
# ./gall.sh -u patch_2026.zip
#
# 3) Encrypted + include untracked files, custom name
# ./gall.sh -p abc123 -u mypatch.zip
##########################################################################

# Initialize variables
ZIP_PWD=""
INCLUDE_UNTRACKED=false
OUT_ZIP=""
ZIP_ARGS=()

cleanup() {
    if [[ -n "${TMP_DIR:-}" && -d "${TMP_DIR}" ]]; then
        rm -rf "${TMP_DIR}"
    fi
}
trap cleanup SIGINT SIGTERM ERR EXIT

show_help() {
    grep '^# Usage:' "$0" -A 22 | sed 's/^# //; s/^#//'
    exit 0
}

# Cross-platform sed in-place helper
sed_inplace() {
    local expr="$1"
    local file="$2"
    if [[ "$(uname -s)" == "Darwin" ]]; then
        sed -i '' "${expr}" "${file}"
    else
        sed -i "${expr}" "${file}"
    fi
}

# Parse command arguments
while [[ $# -gt 0 ]]; do
    arg="$1"
    case "${arg}" in
        -p)
            if [[ -z "$2" ]]; then
                echo "Error: -p requires password argument"
                exit 1
            fi
            ZIP_PWD="$2"
            shift 2
            ;;
        -u|--include-untracked)
            INCLUDE_UNTRACKED=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            if [[ -z "${OUT_ZIP}" ]]; then
                OUT_ZIP="${arg}"
            fi
            shift
            ;;
    esac
done

# Check required commands
command -v git >/dev/null 2>&1 || { echo "Error: git is not installed"; exit 1; }
command -v zip >/dev/null 2>&1 || { echo "Error: zip utility is not installed"; exit 1; }

# Generate default zip filename if not specified
if [[ -z "${OUT_ZIP}" ]]; then
    TS=$(date +%Y%m%d_%H%M%S)
    OUT_ZIP="git_mod_${TS}.zip"
fi

# Force git output in English to avoid parsing issues
export LC_ALL=C

# Temporary workspace
TMP_DIR=$(mktemp -d /tmp/gitpack.XXXXXX)
FILE_LIST="${TMP_DIR}/filelist.txt"
DIFF_FILE="${TMP_DIR}/changes.patch"

# Remove old archive if exists
[[ -f "${OUT_ZIP}" ]] && rm -f "${OUT_ZIP}"

# Generate git diff patch file
git diff HEAD > "${DIFF_FILE}"

# Collect target file list
> "${FILE_LIST}"
if ${INCLUDE_UNTRACKED}; then
    echo ">>> Mode: tracked modified files + untracked new files"
    {
        git diff --name-only HEAD
        git ls-files --others --exclude-standard
    } >> "${FILE_LIST}"
else
    echo ">>> Mode: ONLY tracked modified files (default)"
    git diff --name-only HEAD >> "${FILE_LIST}"
fi

# Remove duplicate entries & filter empty lines
sort -u "${FILE_LIST}" -o "${FILE_LIST}"
sed_inplace '/^$/d' "${FILE_LIST}"

# Check if no changed files
if [[ ! -s "${FILE_LIST}" ]]; then
    echo "No modified files detected, exit without creating archive."
    exit 0
fi

echo "==================== File List To Package ===================="
cat "${FILE_LIST}"
echo "=============================================================="

# Build zip command arguments
if [[ -n "${ZIP_PWD}" ]]; then
    ZIP_ARGS+=("-P" "${ZIP_PWD}")
    echo ">>> Zip encryption enabled"
fi

# Add changes.patch directly into ZIP root ( -j discard directory path )
zip ${ZIP_ARGS[@]+"${ZIP_ARGS[@]}"} -q -j "${OUT_ZIP}" "${DIFF_FILE}"

# Add source files, support paths with spaces
while IFS= read -r fname; do
    [[ -z "${fname}" ]] && continue
    if [[ -f "${fname}" || -d "${fname}" ]]; then
        zip ${ZIP_ARGS[@]+"${ZIP_ARGS[@]}"} -q "${OUT_ZIP}" "${fname}"
    fi
done < "${FILE_LIST}"

echo -e "\n✅ Packaging completed: ${OUT_ZIP}"
if [[ -n "${ZIP_PWD}" ]]; then
    echo "🔒 Archive password: ${ZIP_PWD}"
fi
