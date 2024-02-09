#!/usr/bin/bash
# ---
# Main program
# ---

case "$1" in
    get-firmware-info)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: get-firmware-info"
        exit 64
        ;;
    install)
        # Perform normal processing for this action.
        docker run --rm -v /dev:/dev -v $SECONDARY_FIRMWARE_PATH:/firmware.bin \
            --device-cgroup-rule='c 207:16 rmw' --device-cgroup-rule='c 254:* rmw' \
            __container_image_name__ > /var/logs
        echo '{"status": "ok", "message": "New firmware flashed"}'
        exit 0
        ;;
    complete-install)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: complete-install"
        exit 64
        ;;
    *)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: ERROR event $1 not supported"
        exit 64
        ;;
esac