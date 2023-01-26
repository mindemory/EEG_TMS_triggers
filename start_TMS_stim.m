function start_TMS_stim
s = TMS('Open')
TMS('Enable', s);
TMS('Main', s);
TMS('Amplitude', s, 25);
pause (2)
TMS('Single', s); 
TMS('Amplitude', s, 75);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 55);
pause (2)
TMS('Single', s);   
pause (1)
TMS('Timing', s);
TMS('Amplitude', s, 33);
pause (2)
TMS('Train', s);
pause (20)
TMS('Pause', s);
pause (5)
TMS('Train', s);
pause (2)
TMS('Main', s);
pause (1)
TMS('Single', s); 
TMS('Amplitude', s, 68);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 47);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 15);
pause (2)
TMS('Single', s); 
TMS('Amplitude', s, 80);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 62);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 28);
pause (2)
TMS('Single', s); 
TMS('Amplitude', s, 74);
pause (2)
TMS('Single', s);
TMS('Amplitude', s, 50);
pause (2)
TMS('Single', s);
TMS('Disable', s);
TMS('Close', s);
end