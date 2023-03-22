from pyftdi.ftdi import Ftdi
from pyftdi.gpio import GpioAsyncController
import time

PulseWidth = 0.05

#add the brainproducts Triggerbox to the known devices
Ftdi.add_custom_vendor(0x1103, "Brainproducts")
Ftdi.add_custom_product(0x1103, 0x0021)

#define the two GPIO ports (0-7 and 8-15)
gpio1 = GpioAsyncController()

#search for devices and print them
#print("Found devices:")
#print(Ftdi.show_devices())

#0 is in, 1 is out
gpio1.configure('ftdi://Brainproducts:0x0021:TB1MSF2H/1', direction=0b11111111) #1-8, all outputs

curr_val = 0

gpio1.write(int(curr_val))
time.sleep(PulseWidth)

#last_gpio2 = 0
#for ii in range(256):
#	print(ii)
	#gpio1.write(ii)
#	gpio2.write(ii)
#	time.sleep(PulseWidth)

#while trig_value < 100:
#	#trig_value = int(input('Next trig value:'))
#	print(trig_value)
#	gpio1.write(trig_value)
		
#time.sleep(PulseWidth)

gpio1.close()