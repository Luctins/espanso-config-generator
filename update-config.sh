#!/usr/bin/env zsh

SOURCE_DIR="$1"
CATEGORY="$2"
OUT_F="$3"

# echo "args source_d: $SOURCE_DIR, category: $CATEGORY, output: $OUT_F"

# POSITIONAL=()
# while [[ $# -gt 0 ]]; do
#     case $1 in
#         *)

#         ;;
#     esac
# done
# set -- "${POSITIONAL[@]}"

tee $OUT_F <<YAML
name: image-autogen-${CATEGORY}
parent: images
backend: Clipboard

matches:
YAML

for image in $(ls "${SOURCE_DIR}/${CATEGORY}"); do
    tee -a $OUT_F <<YAML
- trigger: ';img autogen ${image};'
  image_path: '\$CONFIG/images/library/${CATEGORY}/${image}'
YAML
done
