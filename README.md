# tv-screensaver

## Dependencies

- Device that supports CEC (probably a RPi with direct HDMI connection, NOT via USB adapter)

```bash
sudo apt install \
    # For HDMI CEC remote device control
    cec-utils \
    # For displaying images in a terminal
    fim
```

## Secrets

An api token for _API FLASH_ is required. This should be placed in a `.env` file adjacent to `./entrypoint.sh`:

```bash
# .env
API_FLASH_TOKEN=tokenvaluetokenvaluetokenvalue
```

## Invocation

The script is designed to run forever, and be killed by the caller.

See `./entrypoint.sh` for such an invocation, which uses `timeout` to shutdown after a fixed period.

Invoke with timeout, which the script is designed to support.

### Optional arguments

Mainly for testing, the following optional arguments are provided:

- `--no-download`: do not download a new screensaver image, use the cache
- `--no-cec`: skip any HDMI CEC comamnds

## Scheduling

Set up a cron job to run the screensaver periodically. This will take care of turning on and off the TV periodically.

```bash
# /etc/crontab
...
# run every day at 6am, and shutdown after 12 hours
0 6 * * 1-5 pi /home/pi/tv-screensaver/entrypoint.sh --duration 43200
```
