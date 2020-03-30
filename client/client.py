#!/usr/bin/env python
import random
import time
from pylibftdi import Device, USB_PID_LIST, USB_VID_LIST

RANDOM = False
INPUT = False

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


def translate(msg):
    write = (msg[0] >> 7) == 1
    address_group = (msg[0] & 127)
    address = int.from_bytes(msg[1:3], byteorder='big')
    data = int.from_bytes(msg[3:5], byteorder='big')
    print(f"Write: {write}")
    print(f"Address group: {address_group}")
    print(f"Address: {address}")
    print(f"Data: {data}")


def slip(msg):
    # Escape ESC and END characters, and wrap the result with ENDs
    msg = msg.replace(SLIP_ESC, SLIP_ESC + SLIP_ESC_ESC)
    msg = msg.replace(SLIP_END, SLIP_ESC + SLIP_ESC_END)
    return SLIP_END + msg + SLIP_END


def unslip(msg):
    # Strip off the wrapping ENDs, and unescape ESCs and ENDs
    if (msg[0] != ord(SLIP_END)) or (msg[-1] != ord(SLIP_END)):
        raise RuntimeError('SLIPped message does not start and end with SLIP_END: %02x %02x' % (msg[0], msg[-1]))
    msg = msg[1:-1]
    msg = msg.replace(SLIP_ESC + SLIP_ESC_END, SLIP_END)
    msg = msg.replace(SLIP_ESC + SLIP_ESC_ESC, SLIP_ESC)
    return msg


def get_msg(data):
    first_end = data.find(SLIP_END)
    if first_end == -1:
        return b'', b''
    elif first_end != 0:
        print(f'Dropping {first_end} bytes from data stream')

    data = data[first_end:]
    non_end = 0
    for i, b in enumerate(data):
        if b != ord(SLIP_END):
            non_end = i
            break

    if non_end == 0:
        return b'', b''

    next_end = data.find(SLIP_END, non_end)
    if next_end == -1:
        return b'', b''

    return unslip(data[non_end-1:next_end+1]), data[next_end+1:]


def tobinary(i):
    print(f"{i:b}")


def write_bytes(dev, b):
    print(len(b))
    print(b)
    m = slip(bytes(b))
    print(m)
    dev.write(m)
    if INPUT:
        input()
    else:
        time.sleep(0.2)


def read_bytes(dev):
    while(True):
        bytes = dev.read(4096)
        if(len(bytes) > 0):
            break
        time.sleep(0.1)

    print("Received", bytes)
    while(len(bytes)>0):
        print(len(bytes))
        msg, bytes = get_msg(bytes)
        if(msg):
            print(msg)
            translate(msg)
            if INPUT:
                input()


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
            write_bytes(dev, [32, 0, 64])
            read_bytes(dev)

            write_bytes(dev, [160, 0, 64, 0, 0])
            write_bytes(dev, [32, 0, 64])
            read_bytes(dev)

            write_bytes(dev, [160, 0, 4, 0, 1])
            write_bytes(dev, [32, 0, 4])
            read_bytes(dev)

            write_bytes(dev, [160, 0, 4, 0, 0])
            write_bytes(dev, [32, 0, 4])
            read_bytes(dev)
