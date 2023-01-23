s = TMS('Open')
fwrite(s, [254, 3, 2, 1, 0, 139, 255], 'uint8');
pause(2);
fwrite(s, [254, 3, 7, 1, 0, 190, 255], 'uint8');
pause(2);
fwrite(s, [254, 3, 7, 2, 0, 235, 255], 'uint8');
pause(2);
TMS('Disable', s);
TMS('Close', s);