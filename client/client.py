#!/usr/bin/env python
import sys
import random
import time
from pylibftdi import Device, USB_PID_LIST, USB_VID_LIST
from ctypes import *

STYX_VID = 0x2a19
STYX_PID = 0x1007

USB_VID_LIST.clear()
USB_VID_LIST.append(STYX_VID)

USB_PID_LIST.clear()
USB_PID_LIST.append(STYX_PID)
SLIP_END = b'\xC0'
SLIP_ESC = b'\xDB'
SLIP_ESC_END = b'\xDC'
SLIP_ESC_ESC = b'\xDD'


def slip(msg):
    # Escape ESC and END characters, and wrap the result with ENDs
    msg = msg.replace(SLIP_ESC, SLIP_ESC + SLIP_ESC_ESC)
    msg = msg.replace(SLIP_END, SLIP_ESC + SLIP_ESC_END)
    return SLIP_END + msg + SLIP_END


def tobinary(i):
    print(f"{i:b}")


def write_byte(dev, i, y=False):
    m = slip(bytes([i]))
    print(m)
    print(f"{i:08b}")
    dev.write(m)
    if y:
        time.sleep(0.4)
    else:
        input()


with Device() as dev:
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x00)
    time.sleep(0.01)
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x40)

    dev.ftdi_fn.ftdi_set_latency_timer(5)
    dev.ftdi_fn.ftdi_setflowctrl(0)
    dev.ftdi_fn.ftdi_usb_purge_buffers()

    while True:
        i = random.randint(0, 256)
        write_byte(dev, i
                   )

    write_byte(dev, 255)
    write_byte(dev, 192)
    write_byte(dev, 255)
    write_byte(dev, 219)
    write_byte(dev, 255)
    write_byte(dev, 192)
    write_byte(dev, 255)
    write_byte(dev, 219)
    write_byte(dev, 255)