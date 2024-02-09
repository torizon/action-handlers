# syntax=docker/dockerfile:1.6.0

FROM torizon/debian:3-bookworm

RUN apt update && apt install -y --no-install-recommends \
    git python3 python3-pip python3-serial gpiod libgpiod2 && \
    apt-get clean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/espressif/esptool.git /esptool

WORKDIR /esptool

RUN cat <<EOF > /update.sh
#!/bin/sh
set -e

echo "Updating external firmware ..."
sleep 1

# Set boot configuration to bootloader
gpioset gpiochip0 0=0
sleep 0.2

# Reset the ESP8266
gpioset gpiochip0 1=0
sleep 0.2
gpioset gpiochip0 1=1
sleep 0.2

# Load new firmware (flash)
python3 ./esptool.py --port /dev/ttymxc0 write_flash -fm dio 0x00000 /firmware.bin
sleep 1

# Set the normal boot configuration again and restart
gpioset gpiochip0 0=1
sleep 0.2
gpioset gpiochip0 1=0
sleep 0.2
gpioset gpiochip0 1=1
sleep 1

echo "Sucess!"
EOF

RUN chmod +x /update.sh

CMD [ "/update.sh" ]