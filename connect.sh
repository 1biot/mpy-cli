#!/bin/bash
JSON_CONFIG=$(cat "$PWD/.mpy.json")
DEVICE=$(echo "$JSON_CONFIG" | jq -r .address)
if [ -z "${DEVICE}" ] || [ "${DEVICE}" = null ]; then
    echo "-E|Set your device address"
    exit 1
fi

echo "mpremote connect \"${DEVICE}\" -- $*"
mpremote connect "${DEVICE}" -- "$*"