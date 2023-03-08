#!/bin/bash

JSON_CONFIG=$(cat "$PWD/.mpy.json")

DEVICE=$(echo "$JSON_CONFIG" | jq -r .address)
if [ -z "${DEVICE}" ] || [ "${DEVICE}" = null ]; then
    echo "-E|Set your device address"
    exit 1
fi

DELAY=$(echo "${JSON_CONFIG}" | jq -r .delay)

function help() {
  echo "Help to device.sh try mpy-cli device --help"
}

function upload_dir() {
  dir_to_upload="${1}"
  if [ ! -d "$dir_to_upload" ]; then
    echo "-E|Folder $dir_to_upload does not exits"
    return 1
  fi

  items_in_dir=()
  while IFS='' read -r line; do items_in_dir+=("$line"); done < <(ls -a "${dir_to_upload}")
  for dir_item in "${items_in_dir[@]}"
  do
    if [ "$dir_item" != "." ] && [ "$dir_item" != ".." ] && [ "$dir_item" != ".DS_Store" ]; then
      [[ "$dir_to_upload" == "src" ]] && upload_target="" || upload_target="$dir_to_upload/"
      echo "ampy --port \"${DEVICE}\" -d \"${DELAY:=0}\" -- put \"$dir_to_upload/$dir_item\" \"$upload_target$dir_item\""
      ampy --port "${DEVICE}" -d "${DELAY:=0}" -- put "$dir_to_upload/$dir_item" "$upload_target$dir_item"
    fi
  done
}

if [ -z "${2}" ]; then
  help
  exit 1
fi

if [ "${2}" = 'upload-all' ]; then
  include_dir=$(echo "${JSON_CONFIG}" | jq -r '.include_dir')
  upload_dir "${include_dir//\'/}"
  exit
else
  echo "ampy --port \"${DEVICE}\" -d \"${DELAY:=0}\" -- ${*:2}"
  ampy --port "${DEVICE}" -d "${DELAY:=0}" -- "${*:2}"
fi
