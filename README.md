# EEG-TMS Triggers
This repository consists of codes borrowed from BrainProducts and MagVenture and modified to send triggers to EEG and TMS systems at NYU Department of Psychology.

The codes are made public for use, however, no guarantee for running for any system is provided. Feedback is appreciated to make the code more generalizable.

## EEG Trigger code:
The codes are meant to work via Ubuntu as the stimulus presentation system. The stimulus presentation USB system is connected to BrainProducts Triggerbox via USB cable, which is then connected to BrainVision ActiPower via DB-25 port. To ensure that triggers are sent, on the Triggerbox, all the bits should be set to PC. The specific settings for each bit can be changed in the DigitalPortSettings of BrainVision Recorder.

BrainProducts Triggerbox has an FTDI Chip that creates a virtual serial port to be detected on Ubuntu. However, without appropriate drivers, the USB port will not be listed in /dev/. Pytdi module of Python can help detect the correct port. Additionally, the hardware is only accessible to root. Therefore, in order to implement the script, you should run the script as sudo:
> sudo python3 trigger_send.py

First step is to obtain the device ID. Run the script as root and the error produced should give you the device ID. Replace
gpio1.configure('ftdi://Brainproducts.0x0021:TBXXXXXX/1', direction=0b11111111)
and
gpio2.configure('ftdi://Brainproducts.0x0021:TBXXXXXX/2', direction=0b00000000)
with the correct device ID.

To trigger the EEG system, you will be mostly using ports 0-7 which are triggered by:
gpio.write({trigger_code})

Note: This is a Python script. In order to run the script from MATLAB, you can simply run it as:
system('sudo python3 /path_to_script/trigger_send.py')

## TMS Trigger code:
The codes are meant to work with Ubuntu as the stimulus presentation system. The code uses "serial" function to detect and communicate with the serial port. However, this function works only for versions earlier than MATLAB 2019b. For later versions, the code needs to be modified with the updated function "serialport". This is a potential to-do for this repository.


