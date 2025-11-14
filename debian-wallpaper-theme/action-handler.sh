#!/usr/bin/bash
#
# Custom action handler for changing the wallpaper using the 
# default wallpapers available in Debian
# This was tested on Debian 12, after installing Torizon Connector
#

case "$1" in
    get-firmware-info)
        # Perform normal processing for this action.
        if [ -f ${SECONDARY_FIRMWARE_PATH} ]; then
                echo '{"status": "ok", "message": "Current background theme: '$(cat ${SECONDARY_FIRMWARE_PATH})'"}'
                exit 0
        else
                echo '{"status": "ok", "message": "Currently there is no previous package"}'
                exit 0
        fi
        exit 64
        ;;
    install)
        # Perform normal processing for this action.
        NEW_THEME_NAME=$(cat ${SECONDARY_FIRMWARE_PATH})
        NEW_BACKGROUND_PATH=/usr/share/desktop-base/${NEW_THEME_NAME}/wallpaper/gnome-background.xml
        if [ -f ${NEW_BACKGROUND_PATH} ]; then
                sudo -u lava-user DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u lava-user)/bus" gsettings set org.gnome.desktop.background picture-uri 'file://'${NEW_BACKGROUND_PATH}
                echo '{"status": "ok", "message": "New background theme installed: '${NEW_THEME_NAME}'"}'
                exit 0
        else
                echo '{"status": "failed", "message": "Theme '${NEW_THEME_NAME}' (with background path '${NEW_BACKGROUND_PATH}') does not exist!"}'
                exit 65
        fi
        exit 64
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

