#!/bin/bash

set -euo pipefail

URL="https://api.apiflash.com/v1/urltoimage?access_key=${API_FLASH_TOKEN}&wait_until=page_loaded&url=https://apodviewer.github.io&delay=10&width=3840&height=2160&quality=95"
curl --silent "$URL" > apod-today.jpg
