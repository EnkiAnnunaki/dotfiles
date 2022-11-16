#!/usr/bin/env bash

YADM_CONFIG=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )/config_templates" &> /dev/null && pwd )
LAUNCH_AGENTS_DIR="${HOME}/Library/LaunchAgents/"

if [[ -d "${LAUNCH_AGENTS_DIR}" ]]; then
  cp -fR ${YADM_CONFIG}/LaunchAgents/*.plist "${LAUNCH_AGENTS_DIR}/"
fi

