# EEG-TMS Triggers
This repository contains codes that have been adapted from BrainProducts and MagVenture for the purpose of sending triggers to EEG and TMS systems at the Center for Brain Imaging (CBI) at NYU's Department of Psychology.

Although the codes are available for public use, we do not provide any guarantee of their compatability with all systems. We welcome feedback to improve the generalizability of the codes.

## Adding repository to path
Make sure to add repositories to path using:

> addpath('/path_to_repository/EEG_TMS_triggers')
# TMS Trigger code:
These scripts are designed to be compatible with Ubuntu as the stimulus presentation system. The "serial" function is utilized to identify and interact with the serial port. Please note that this function is only compatible with MATLAB versions prior to 2019b. For MATLAB 2019b or later, the code must be adjusted to use the updated "serialport" function. Updating this functionality in the repository is a possible task for the future.

## Device Setup:
MagVenture X100 is connected to stimulus presentation PC via DB-9 to DB-9 Null modem cable plus a serial to USB converter.
<div style="display: flex; ; max-width: 30vw">
<img
  src="img/DB-9_TMS.jpeg"
  alt="TMS connection (2)"
  title="TMS connection (1)"></img>
<img
  src="img/Serial_to_USB_TMS.jpeg"
  alt="TMS connection (2)"
  title="TMS connection (2)"></img>
<img
  src="img/USB_connection_TMS.jpeg"
  alt="TMS connection (3)"
  title="TMS connection (3)"></img>
</div>
Make sure that the connections are right and TMS is connected to stimulus presentation PC via USB and not serial port as shown above.

## Triggering System
Trigger codes are present in "TMS.m" file. Refer to TMS.m for appropriate trigger codes. However, a general pipeline to send 1 pulse would be:

> s = TMS('Open') \
> TMS('Enable', s); \
> TMS('Main', s); \
> TMS('Amplitude', s, 33); % Sets amplitude to 33% MSO \
> TMS ('Single', s); \
> pause(1); \
> TMS ('Disable', s); \
> TMS('Close', s); 

Another example to send a train of pulses is:

> s = TMS('Open') \
> TMS('Enable', s); \
> TMS('Main', s); \
> TMS('Timing', s); % Use this page on TMS system to determine pulse protocol \
> TMS('Amplitude', s, 33); % Sets amplitude to 33% MSO \
> TMS ('Train', s); \
> WaitSecs(pulse_dur); % pulse_dur should be seconds \
> pause(1); \
> TMS ('Disable', s); \
> TMS('Close', s); 

WaitSecs requires Psychtoolbox so make sure Psychtoolbox is enabled. You can also run it without Psychtoolbox using pause instead of WaitSecs but that can be temporally less precise.

Run "timing_tester_TMS.m" script with your protocol to make sure the timing of the code matches your expected pulse duration.

# EEG Trigger code:
## Triggerbox settings
The codes are tested to work on Ubuntu as the stimulus presentation PC. The stimulus presentation PC is connected to BrainProducts Triggerbox via USB Male to MinDisplay Male cable, which is then connected to BrainVision ActiPower via DB-25 port. To ensure that triggers are received via stimulus PC, all 7 bits on Triggerbox should be set to PC. The specific settings for each bit (Low 1 vs High 1, Stimulus vs Response) can be changed in the from BrainVision Recorder (in Menu bar, look for Amplifier -> Digital Port Settings...).

## How to call the script?
BrainProducts Triggerbox has an FTDi Chip that creates a virtual serial port. However, if you are using Ubuntu, without appropriate drivers, the USB port will not be listed in /dev/. PyFtdi module of Python (https://eblot.github.io/pyftdi/) can be used to detect this serial port. Additionally, the hardware is only accessible to root. You can execute the script from terminal as:
> sudo python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag0.py 

If you are running the script from MATLAB, you can call it as:

> system('sudo python /path_to_repository/EEG_TMS_triggers/EEG/eegflag0.py')

In order to ensure that the script can run from the terminal, either run it from an account that has root access or add the script to sudoers. In order to add it to sudoers, from the account with root access run:
> sudo visudo

Scroll to the bottom of the sudoers file and add:

> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag0.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag1.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag2.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag3.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag4.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag5.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag6.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag7.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag8.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag9.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag10.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag11.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag12.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag13.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag14.py \
> username ALL=(ALL) NOPASSWD: /usr/bin/python3 /path_to_repository/EEG_TMS_triggers/EEG/eegflag15.py 

Replace "username" with the actual username of the account and "path_to_repository" with the actual path to where the repository is cloned. Save and close the file. Now the user "username" can run the Python script with root privelges without being prompted a password.

## Setting up BrainProducts device ID
First step is to obtain the device ID. Run the script as root as mentioned above and the error produced should give you the device ID. Replace
> gpio1.configure('ftdi://Brainproducts.0x0021:TBXXXXXX/1', direction=0b11111111)

with the correct device ID in all eegflag*.py scripts. This has to be done only once.

The triggers can be written to the EEG system via:
> gpio1 .write({trigger_code})
> time.sleep(PulseWidth)

# Sending Triggers
The triggers can be sent via running eegflag*.py scripts as mentioned above. Each script would make a handshake, send trigger corresponding the value of the file name (except for eegflag0.py which sends trigger 'R  1'). As of this working, there are files sending 15 unique triggers. However, this can be easily expanded to send many more unique triggers. Lastly, the gpio1.close() closes the serial port by sending 'S 15' trigger.
Hence, by running each file, there are 3 to 4 triggers sent, only 1 of which is relevant. Therefore, downstream EEG event file reading needs to be done with caution.

The triggers can be sent from MATLAB as:
> system('sudo python /path_to_repository/EEG_TMS_triggers/EEG/eegflag0.py') \
> system('sudo python /path_to_repository/EEG_TMS_triggers/EEG/eegflag1.py')