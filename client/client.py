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


def write_bytes(dev, b, y=False):
    print(len(b))
    m = slip(bytes(b))
    print(m)
    #print(f"{i:08b}")
    #if(len(m)>3):
    #    print("-------------------------------------------------------------------------------")
    dev.write(m)
    if y:
        time.sleep(0.2)
    else:
        input()


def write_bytes_slow(dev, b):
    m = slip(bytes(b))
    for bb in m:
        print(bb)
        dev.write(bb)
        input()


with Device() as dev:
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x00)
    time.sleep(0.01)
    dev.ftdi_fn.ftdi_set_bitmode(0xFF, 0x40)

    dev.ftdi_fn.ftdi_set_latency_timer(5)
    dev.ftdi_fn.ftdi_setflowctrl(0)
    dev.ftdi_fn.ftdi_usb_purge_buffers()

    if True:
        while True:
            i1 = random.randint(0, 255)
            i2 = random.randint(0, 255)
            i3 = random.randint(0, 255)

            print(i1, i2, i3)
            write_bytes(dev, [i1, i2, i3], y=True)
    else:
        slow = False
        while True:
            if slow:
                write_bytes_slow(dev, [254, 253, 252])
                write_bytes_slow(dev, [192, 219, 255])  # Escape END
                write_bytes_slow(dev, [254, 13, 15])
                write_bytes_slow(dev, [15, 219, 34])  # Escape ESC
                write_bytes_slow(dev, [254, 1, 1])
                continue
            else:
                write_bytes(dev, [254, 253, 252])
                write_bytes(dev, [192, 219, 255])  # Escape END
                write_bytes(dev, [254, 13, 15])
                write_bytes(dev, [15, 219, 34])  # Escape ESC
                write_bytes(dev, [254, 1, 1])
                write_bytes(dev, [192, 1, 2, 3])
                write_bytes(dev, [254, 2, 2])
                write_bytes(dev, [2, 219])
                write_bytes(dev, [2, 2, 219])
                write_bytes(dev, [254])
                write_bytes(dev, [254])
                write_bytes(dev, [1, 2, 192])
