# FTDI interface for the Numato Styx FPGA devboard

USB interface based on the FTDI FT2232H chip present on the Styx board. This interface
allows the exchange of data between an application running on the host computer and
the FPGA.

This is a slightly modified version of part of Mike Stewart's AGC monitor project, see
https://github.com/thewonderidiot/agc_monitor.git. 


## Installation
These are instructions for Ubuntu 18.04. 

- Install libftdi: `sudo apt-get install libftdi1-dev`
- Add a udev rule for the Styx board:
  - Create the rule file: `sudo vim /etc/udev/rules.d/10-styx.rules`
  - Add the line: `ACTION=="add", ATTRS{idProduct}=="1007", ATTRS{idVendor}=="2a19", MODE="666", GROUP="dialout"`
  - Reload the udev rules: `sudo udevadm control --reload`
- Make sure the Styx channel A is configured for 245FIFO and the D2XX driver (I used the FT_Prog 
  utility provided by FTDI, which is a Windows-only executable)
- Connect the Styx board
- Create a virtualenv and install `pylibftdi` using pip
- Before opening the device, add the Styx PID to the USB_PID_LIST and the Styx VID to the USB_VID_LIST

## Data format
### Command
From application to FPGA.
- Byte 1: first bit: read or write. Next 7 bits: address group
- Byte 2 and 3: address
- Byte 4 and 5: data (for write commands)

### Message
From FPGA to application (response).
