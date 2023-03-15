from pyftdi.ftdi import Ftdi
from pyftdi.gpio import GpioAsyncController
import time

PulseWidth = 0.05

#add the brainproducts Triggerbox to the known devices
Ftdi.add_custom_vendor(0x1103, "Brainproducts")
Ftdi.add_custom_product(0x1103, 0x0021)

#define the two GPIO ports (0-7 and 8-15)
gpio1 = GpioAsyncController()

#0 is in, 1 is out
gpio1.configure('ftdi://Brainproducts:0x0021:TB1MSF2H/1', direction=0b11111111) #1-8, all outputs

curr_val = 6

gpio1.write(int(curr_val))
time.sleep(PulseWidth)

gpio1.close()