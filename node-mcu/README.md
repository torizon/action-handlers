# NodeMCU (ESP8266) Serial Port Example

In this example, a NodeMCU is connected to a Verdin iMX8M Plus (on the Dahlia Carrier Board) through a Serial Port. There is a blinking LED connected to a GPIO, and the updated firmware can change the blink frequency of the LED.

**Note:** Since there are external dependencies to flash the firmware on the NodeMCU, a container capable of doing it needs to be built beforehand. An example Dockerfile of this container is also provided.

The image below illustrates the setup:

![NodeMCU, Verdin iMX8M Plus and Dahlia setup](https://docs.toradex.com/114509-verdin_imx8mp_dahlia_esp8266_12-e_nodemcu.png)

For a full overview of this example, check this [Toradex Article](https://developer.toradex.com/torizon/torizon-platform/torizon-updates/how-to-use-subsystem-updates/#use-case-subsystem-update-in-an-ai-thinker-esp8266-12-e-nodemcu).
