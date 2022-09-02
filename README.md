# tv-screensaver

## Dependencies

- Device that supports CEC (probably a RPi with direct HDMI connection, NOT via USB adapter)

```bash
sudo apt install \
    # For HDMI CEC remote device control
    cec-utils \
    # Control window managers (for fullscreen support)
    wmctrl
```

## Invocation

Invoke with timeout, which the script is designed to support.

```bash
# Load secrets from env file
# 8 hours timeout
env $(cat .env | xargs) timeout 28800 ./tvs.sh
```
