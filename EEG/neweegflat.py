#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  4 14:45:11 2024

@author: netadmin
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import serial
ser = serial.serial('/dev/tty.usbserial-D30C1FIE', 115200, timeout = 1)
ser.write(2)
ser.close()

import serial 
port = serial.Serial('/dev/tty.usbserial-D30C1FIE',115200, timeout=1) 
port.write(str.encode('1'))
port.flush()
port.close()
