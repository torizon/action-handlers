# Action Handlers for Subsystem Updates

Update any subsystem on your embedded device. Example use cases are:

- Content payloads (videos, images, machine learning models, ...)
- Cortex M4 firmware
- External MCUs
- Configuration files

Each use case is defined by an Action Handler file, which describes how to update that system.

Full documentation is available at the [Toradex Developer Website](https://developer.toradex.com/torizon/torizon-platform/torizon-updates/subsystem-updates-overview).


## Structure of an Action Handler

There are 3 important actions in every Action Handler file:

1. `get-firmware-info`

    This action will be invoked whenever the update client needs to gather information about the payload currently installed on the Target Subsystem. Such information is employed by the Aktualizr update client when sending a manifest with the installed payload versions to the Update server. The reported installed version that will be displayed in logs and Web interfaces.

2. `install`

    This action will be invoked whenever the update client needs to deliver new payload to the target subsystem. The Aktualizr update client will provide a path for the last delivered payload, and your action handler will deliver it to the target subsystem.

3. `complete-install`

    This action will be invoked by the update client on its startup if there are pending updates for the target subsystem to give it an opportunity to complete a previous installation.

## Minimal Example

This action handler won't do anything with the downloaded artifact, but it illustrates the general structure of an Action Handler file. Please look at the [documentation](https://developer.toradex.com/torizon/torizon-platform/torizon-updates/subsystem-updates-overview) for more details.

```bash
#!/usr/bin/bash
# ---
# Main program
# ---
case "$1" in
    get-firmware-info)
        echo "ACTION HANDLER: get-firmware-info"
        exit 64
        ;;
    install)
        echo '{"status": "ok", "message": "Installation successful!"}'
        exit 0 
        ;;
    complete-install)
        echo "ACTION HANDLER: complete-install"
        exit 64
        ;;
    *)
        # Perform normal processing for this action.
        echo "ACTION HANDLER: ERROR event $1 not supported"
        exit 64
        ;;
esac
```