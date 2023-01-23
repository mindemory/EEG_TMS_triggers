from pyftdi.ftdi import Ftdi
from pyftdi.gpio import GpioAsyncController
import time
import sys

trig_value = 0#int(sys.argv[1])
PulseWidth = 0.1

#add the brainproducts Triggerbox to the known devices
Ftdi.add_custom_vendor(0x1103, "Brainproducts")
Ftdi.add_custom_product(0x1103, 0x0021)

#define the two GPIO ports (0-7 and 8-15)
gpio1 = GpioAsyncController()
gpio2 = GpioAsyncController()

#search for devices and print them
print("Found devices:")
print(Ftdi.show_devices())

#0 is in, 1 is out
gpio1.configure('ftdi://Brainproducts:0x0021:TB1MSF2H/1', direction=0b11111111) #1-8, all outputs
#gpio2.configure('ftdi://Brainproducts:0x0021:TB1MSF2H/2', direction=0b00000000) #8-15, all inputs

gpio1.write(0x00) # set all outputs to zero
#gpio2.write(0x00) # set all outputs to zero

print("Read GPIO:")
print(gpio1.read())
#last_gpio2 = 0
#for ii in range(256):
#	print(ii)
	#gpio1.write(ii)
#	gpio2.write(ii)
#	time.sleep(PulseWidth)

while trig_value < 100:
	trig_value = int(input('Next trig value:'))
	print(trig_value)
	gpio1.write(trig_value)
		
#time.sleep(PulseWidth)

#gpio1.write(0xEE)

#close
gpio1.close()
#gpio2.close()

