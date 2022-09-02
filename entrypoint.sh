#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

eprintln() {
  >&2 echo "$1"
}

DURATION=30

parse_args() {
  while [[ $# -gt 0 ]]; do
    local argname="$1"
    case "$argname" in
      --duration)
        DURATION="$2"
        shift
        ;;
    esac
    shift
  done
}

parse_args "$@"

env $(xargs < .env) timeout "$DURATION" ./tvs.sh 2> tvs.log
