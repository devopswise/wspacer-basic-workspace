#!/bin/bash

set -e

TTYD_BASE_PATH="${TTYD_BASE_PATH:=/}"
screen -dmS bash-session bash
ttyd --base-path $TTYD_BASE_PATH bash -c 'screen -r bash-session'
