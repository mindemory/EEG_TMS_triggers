# EEG-TMS Triggers
This repository consists of codes borrowed from BrainProducts and MagVenture and modified to send triggers to EEG and TMS systems at NYU Department of Psychology.

The codes are made public for use, however, no guarantee for running for any system is provided. Feedback is appreciated to make the code more generalizable.

## EEG Trigger code:
The codes are meant to work via Ubuntu as the stimulus presentation system. The stimulus presentation system is connected to BrainProducts Triggerbox via USB cable, which is then connected to BrainVision ActiPower via DB-25 port. To ensure that triggers are sent, on the Triggerbox, all 7 bits on Triggerbox should be set to PC. The specific settings for each bit (Low 1 vs High 1, Stimulus vs Response) can be changed in the from BrainVision Recorder (in Menu bar, look for Amplifier -> Digital Port Settings...).

BrainProducts Triggerbox has an FTDi Chip that creates a virtual serial port. However, if you are using Ubuntu, without appropriate drivers, the USB port will not be listed in /dev/. PyFtdi module of Python (https://eblot.github.io/pyftdi/) can be used to detect this serial port. Additionally, the hardware is only accessible to root. Therefore, in order to implement the script, from Terminal, you can execute the script as sudo:
> sudo python3 trigger_send.py
If you are running the script from MATLAB, you can call it as:
> system('sudo python trigger_send.py')

In order to ensure that the script can run from the terminal, either run it from an account that has root access or add the script to sudoers. In order to add it to sudoers, from the account with root access, from Terminal run:
> sudo visudo
At the end of the sudoers file, add:
> blurb

First step is to obtain the device ID. Run the script as root as mentioned above and the error produced should give you the device ID. Replace
gpio1.configure('ftdi://Brainproducts.0x0021:TBXXXXXX/1', direction=0b11111111)
and
gpio2.configure('ftdi://Brainproducts.0x0021:TBXXXXXX/2', direction=0b00000000)
with the correct device ID.

To trigger the EEG system, you will mostly be using ports 0-7 which are triggered by:
gpio1 .write({trigger_code})

Note: This is a Python script. In order to run the script from MATLAB, you can simply run it as:
system('sudo python3 /path_to_script/trigger_send.py')

## TMS Trigger code:
The codes are meant to work with Ubuntu as the stimulus presentation system. The code uses "serial" function to detect and communicate with the serial port. However, this function works only for versions earlier than MATLAB 2019b. For later versions, the code needs to be modified with the updated function "serialport". This is a potential to-do for this repository.


