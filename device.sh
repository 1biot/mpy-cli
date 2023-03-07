#!/bin/bash

JSON_CONFIG=$(cat "$PWD/.mpy.json")

DEVICE=$(echo "$JSON_CONFIG" | jq -r .address)
if [ -z "${DEVICE}" ] || [ "${DEVICE}" = null ]; then
    echo "-E|Set your device address"
    exit 1
fi

DELAY=$(echo "${JSON_CONFIG}" | jq -r .delay)

if [ "$1" = 'upload' ]; then
  include=($(echo "${JSON_CONFIG}" | jq -r '.include | @sh'))
  for upload_item in "${include[@]}"
  do
    upload_item=${upoad_item//\'/""}
    echo "${upoad_item}"

  done

  echo "==========="

  include=($(ls -a "${PWD}/src/lib"))
  for i in "${include[@]}"
  do
    if [ $i != "." ] && [ $i != ".." ]; then
     echo "src/$i"
    fi
  done

  echo "==========="
fi

exit
ampy --port "${DEVICE}" -d "${DELAY:=0}" -- $@
