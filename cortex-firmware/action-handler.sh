#!/usr/bin/bash
#
# Custom action handler for Cortex M4 firmware updates
# using remoteproc
#

firmware_sanity_check() {
    # Implement a sanity check here to deal with rollback.
    # This is going to be dependent on what the uC firmware
    # is actually doing.  This is just a placeholder for now.
    return 0
}

case "$1" in
    get-firmware-info)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: get-firmware-info"
        exit 64
        ;;
    install)
        # Perform normal processing for this action.
        [ -d /var/cortex-firmware ] || mkdir -p /var/cortex-firmware
        [ -f /var/cortex-firmware/firmware.elf ] && mv /var/cortex-firmware/firmware.elf /var/cortex-firmware/firmware.elf.rollback
        cp "${SECONDARY_FIRMWARE_PATH}" /var/cortex-firmware/firmware.elf
        echo -n /var/cortex-firmware > /sys/module/firmware_class/parameters/path 
        echo stop > /sys/class/remoteproc/remoteproc0/state || true
        echo firmware.elf > /sys/class/remoteproc/remoteproc0/firmware
        echo start > /sys/class/remoteproc/remoteproc0/state
        if firmware_sanity_check; then
            echo '{"status": "ok", "message": "New firmware installed"}'
            exit 0
        else
            # Rollback
            cp /var/cortex-firmware/firmware.elf.rollback /var/cortex-firmware/firmware.elf
            echo stop > /sys/class/remoteproc/remoteproc0/state || true
            echo firmware.elf > /sys/class/remoteproc/remoteproc0/firmware
            echo start > /sys/class/remoteproc/remoteproc0/state
            echo '{"status": "failed", "message": "Firmware rolled back"}'
            exit 65
        fi
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
