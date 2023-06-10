#!/usr/bin/env zsh

SOURCE_DIR="$1"
CATEGORY="$2"
OUT_F="$3"
AUTOGEN_NAME="autog"

function bat_or_cat() {
    if hash bat 2>/dev/null; then
        bat -P "$@"
    else
        echo 'falling back to cat. please install batcat'
        cat "$@"
    fi
}

# echo "args source_d: $SOURCE_DIR, category: $CATEGORY, output: $OUT_F"
# POSITIONAL=()
# while [[ $# -gt 0 ]]; do
#     case $1 in
#         *)

#         ;;
#     esac
# done
# set -- "${POSITIONAL[@]}"

cat >$OUT_F <<YAML
name: image-autogen-${CATEGORY}
parent: default
backend: Clipboard

matches:
YAML

for image in $(ls "${SOURCE_DIR}/${CATEGORY}"); do
   cat >>$OUT_F <<YAML
- trigger: ';img ${CATEGORY} ${image%%.*};'
  image_path: '\$CONFIG/images/stickers/${CATEGORY}/${image}'
YAML
done

bat_or_cat "$OUT_F"
