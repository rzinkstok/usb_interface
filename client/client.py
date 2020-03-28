#!/usr/bin/env python
import sys
import random
import time
from pylibftdi import Device, USB_PID_LIST, USB_VID_LIST
from ctypes import *

RANDOM = False
INPUT = True

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


def write_bytes(dev, b):
    print(len(b))
    m = slip(bytes(b))
    print(m)
    dev.write(m)
    if INPUT:
        input()
    else:
        time.sleep(0.2)


with Device() as dev:
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x00)
    time.sleep(0.01)
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x40)

    dev.ftdi_fn.ftdi_set_latency_timer(5)
    dev.ftdi_fn.ftdi_setflowctrl(0)
    dev.ftdi_fn.ftdi_usb_purge_buffers()

    i1 = 0
    if RANDOM:
        while True:
            i2 = random.randint(0, 255)
            i3 = random.randint(0, 255)

            print(i1, i2, i3)
            write_bytes(dev, [i1, i2, i3])
            i1 += 1
            if i1 > 127:  # Make sure first MSB is 0 so the message is interpreted as 3 byte read command
                i1 = 0
    else:
        while True:
            write_bytes(dev, [160, 0, 64, 0, 1])
            write_bytes(dev, [160, 0, 64, 0, 0])
            write_bytes(dev, [160, 0, 4, 0, 1])
            write_bytes(dev, [160, 0, 4, 0, 0])

