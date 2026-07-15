#!/usr/bin/env bash
# Post-build helper: copies the freshly built VST3 bundle into
# ~/Desktop/vst test/ so it can be loaded by a host for quick testing.
#
# Invoked by CMakeLists.txt as:
#   copy_vst3.sh "$<TARGET_BUNDLE_DIR:Ganymede_VST3>"
# i.e. $1 is the absolute path to the Ganymede.vst3 bundle.

set -euo pipefail

VST3_BUNDLE="${1:-}"
DEST_DIR="${HOME}/Desktop/vst test"

if [[ -z "${VST3_BUNDLE}" ]]; then
    echo "copy_vst3.sh: missing VST3 bundle path argument" >&2
    exit 1
fi

if [[ ! -d "${VST3_BUNDLE}" ]]; then
    echo "copy_vst3.sh: VST3 bundle not found at '${VST3_BUNDLE}'" >&2
    exit 1
fi

mkdir -p "${DEST_DIR}"

BUNDLE_NAME="$(basename "${VST3_BUNDLE}")"
DEST_PATH="${DEST_DIR}/${BUNDLE_NAME}"

rm -rf "${DEST_PATH}"
cp -R "${VST3_BUNDLE}" "${DEST_PATH}"

echo "copy_vst3.sh: copied ${BUNDLE_NAME} -> ${DEST_PATH}"
