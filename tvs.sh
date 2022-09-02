#!/bin/bash

set -euo pipefail

DOWNLOAD=1
CEC=1
API_FLASH_TOKEN="${API_FLASH_TOKEN:-}"

CACHE_DIR="$HOME/.cache/tv-screensaver"
mkdir -p "$CACHE_DIR"
SCREENSHOT_PATH="$CACHE_DIR/apodveiwer-screenshot.jpg"


eprintln() {
  >&2 echo "$1"
}

ceccommand() {
  local command="$1"
  if [[ "$CEC" == 1 ]]; then
    eprintln "Running cec command '$command'"
    echo "$command" | cec-client -s -d 1
  else
    eprintln "Skipping cec command '$command' as --no-cec set"
  fi
}

poweron() {
  eprintln "Powering on"
  ceccommand "on 0"
}

poweroff() {
  eprintln "Powering off"
  ceccommand "standby 0"
}

activeinput() {
  eprintln "Marking as active input"
  ceccommand "as"
}

exit_nicely() {
  eprintln "Exiting nicely"
  poweroff
  exit 0
}

# When asked to terminate by timeout, shutdown gracefully
trap 'exit_nicely' EXIT

parse_args() {
  while [[ $# -gt 0 ]]; do
    local argname="$1"
    case "$argname" in
      --no-download)
        DOWNLOAD=0
        shift
        ;;
      --no-cec)
        CEC=0
        shift
        ;;
      *)
        eprintln "Unknown option $argname"
        exit 1
    esac
  done
}

parse_args "$@"

run() {
  if [[ "$DOWNLOAD" == 1 ]]; then
    if [ -z "${API_FLASH_TOKEN}" ]; then
      eprintln "Missing apiflash.com token. Set environment variable API_FLASH_TOKEN"
      exit 1
    fi

    SOURCE="https://apodviewer.github.io"
    # 12 hours
    TTL="43200"

    # 4k native
    #WIDTH=3840
    #HEIGHT=2160
    #SCALE_FACTOR=1

    # 4k retina
    WIDTH=1920
    HEIGHT=1080
    SCALE_FACTOR=2

    URL="https://api.apiflash.com/v1/urltoimage?access_key=${API_FLASH_TOKEN}&wait_until=page_loaded&url=$SOURCE&delay=10&width=$WIDTH&height=$HEIGHT&scale_factor=$SCALE_FACTOR&quality=95&ttl=$TTL"
    eprintln "Saving render of $SOURCE > $SCREENSHOT_PATH"
    curl --silent "$URL" > "$SCREENSHOT_PATH"
  fi

  poweron
  activeinput

  # fim will run forever, until shutdown
  eprintln "Displaying image"
  fim "$SCREENSHOT_PATH"
}

main() {
  parse_args
  run
}

main
