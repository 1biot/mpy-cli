#!/bin/bash

JSON_CONFIG=$(cat "$PWD/.mpy.json")

DEVICE_ADDRESS=$(echo "$JSON_CONFIG" | jq -r .address)
if [ -z "${DEVICE_ADDRESS}" ] || [ "${DEVICE_ADDRESS}" = null ]; then
    echo "-E|Set your device address"
    exit 1
fi

DEVICE=$(echo "$JSON_CONFIG" | jq -r .device)
if [ -z "${DEVICE}" ] || [ "${DEVICE}" = null ]; then
    echo "-E|Set your device port"
    exit 1
fi

MPY_VERSION=$(echo "$JSON_CONFIG" | jq -r .micropython_version)

ENV_DIRECTORY=$(echo "$JSON_CONFIG" | jq -r .env_path)
if [ -z "${ENV_DIRECTORY}" ] || [ "${ENV_DIRECTORY}" = null ]; then
  ENV_DIRECTORY=".venv"
fi

function init() {
  if [ ! -d "${ENV_DIRECTORY}" ]; then
    python3 -m venv "${ENV_DIRECTORY}"
  fi

  source "${ENV_DIRECTORY}"/bin/activate
  install_stubs
}

function deinit() {
  deactivate
}

function install_stubs() {
  stubs="micropython-${DEVICE}"
  if [ -n "${MPY_VERSION}" ]; then
    stubs="${stubs}-${MPY_VERSION}"
  fi
  stubs="${stubs}-stubs"
  pip install -U "${stubs}"
}

function remove() {
  if [ -d "${ENV_DIRECTORY}" ]; then
    rm -rf "${ENV_DIRECTORY}"
  fi
}

if declare -f "$2" > /dev/null
then
  "${a[@]:1}"
else
  echo "-E|'${2}' is not a known function name" >&2
  exit 1
fi
