#!/usr/bin/bash
#
# Custom action handler for QTimagedisplay application updates
# of the image file.
#

case "$1" in
    get-firmware-info)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: get-firmware-info"
        exit 64
        ;;
    install)
        # Perform normal processing for this action.
        cp $SECONDARY_FIRMWARE_PATH /home/torizon/image.png
        chown torizon.torizon /home/torizon/image.png
        echo '{"status": "ok", "message": "New picture installed"}'
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
