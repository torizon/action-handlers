# Debian 12 Wallpaper Update Example

This example shows how to create a subsystem update on a Debian or Ubuntu-based system with Torizon Connector installed on it.

After installing Torizon Conncetor and provisioning the device to your [Torizon Cloud](https://app.torizon.io) account, you will need to configure your Debian/Ubuntu in order to prepare it to receive the subsystem update via Torizon Cloud.

To create the subsystem update, be sure to follow the documentation on Toradex Developer about the [First Steps With Subsystem Updates](https://developer.toradex.com/torizon/torizon-platform/torizon-updates/first-steps-with-subsystem-updates).

The secondaries configuration for this example is showed below. It must be added as part of the file `/etc/sota/secondaries.json`.

```
{
    "docker-compose": [
        {
          ...
        }
    ],
    "torizon-generic": [
        {
          ...
        },
        {
            "partial_verifying": false,
            "ecu_hardware_id": "debian-wallpaper",
            "full_client_dir": "/var/sota/storage/debian-wallpaper",
            "ecu_private_key": "sec.private",
            "ecu_public_key": "sec.public",
            "firmware_path": "/var/sota/storage/debian-wallpaper/debian-wallpaper-theme.txt",
            "target_name_path": "/var/sota/storage/debian-wallpaper/target_name",
            "metadata_path": "/var/sota/storage/debian-wallpaper/metadata",
            "action_handler_path": "/usr/bin/debian-wallpaper-action-handler.sh"
        }
    ]
}
```

The file `debian-wallpaper-action-handler.sh` must be placed within `/usr/bin/` and must have the execute bit set (`sudo chmod +x /usr/bin/debian-wallpaper-action-handler.sh`).

It is also possible to configure aktualizr to poll for updates more frequently, as explained in [Configuring the Polling Frequency](https://developer.toradex.com/torizon/torizon-platform/torizon-updates/aktualizr-modifying-the-settings-of-torizon-ota-client#configuring-the-polling-frequency). For the sake of this example, the polling frequency can be configured to be 300 seconds.

After modifying aktualizr's pooling time, modifying the secondaries file and placing the action handler script, be sure to restart aktualizr's service (`sudo systemctl restart aktualizr`).

The update packages samples for this example are available within the samples-packages folder. The themes homeworld and joy are actual theme names shipped with Debian 12. The not-a-theme is a non-existent theme in Debian 12. It's purpose is to showcase what happens when a request error processing happens. Each of them must be uploaded to the same Torizon Cloud account where the Debian/Ubuntu system was provisioned. Be sure to provision the files as packages of type debian-wallpaper (in accordance with the value of `ecu_hardware_id` specified in the `secondary.json` file).

After having the 3 packages uploaded to your account, you can start triggering the online updates to your Debian/Ubuntu system.

This example was tested on a Debian 12 system with Torizon Connector installed. To know more about Torizon Connector on Debian and Ubuntu-based systems, please refer to the [Torizon OS documentation on Toradex Developer](https://developer.toradex.com/torizon/torizoncore/torizoncore-technical-overview/#torizon-on-debianubuntu-torizon-connector).
