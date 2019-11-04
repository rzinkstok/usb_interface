FTDI interface for Styx board
-----------------------------

Installation:

- Install libftdi: `sudo apt-get install libftdi1-dev`
- Add a udev rule for the Styx board:
  - Create the rule file: `sudo vim /etc/udev/rules.d/10-styx.rules`
  - Add the line: `ACTION=="add", ATTRS{idProduct}=="1007", ATTRS{idVendor}=="2a19", RUN+="/tmp/styx.sh"`
  - Reload the udev rules: `sudo udevadm control --reload`
- Create a virtualenv and install pylibftdi using pip
- Make sure the Styx channel A is configured for 245FIFO and the D2XX driver
- Connect the Styx board
- Before opening the device, add the Styx PID to the USB_PID_LIST and the Styx VID to the USB_VID_LIST


