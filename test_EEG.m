root_path = '/home/curtislab/Desktop/Mrugank/mgs_stimul/EEG_TMS_triggers';
fname = ['sudo python3 ' root_path '/trigger_send.py &'];

system(fname);

fid = fopen('trig_vals.txt', 'w');
fwrite(fid, '10');
%fclose(fid);

pause(5);

fid = fopen('trig_vals.txt', 'w');
fwrite(fid, '5');
%fclose(fid);

pause(5);

fid = fopen('trig_vals.txt', 'w');
fwrite(fid, '100');
fclose(fid);

