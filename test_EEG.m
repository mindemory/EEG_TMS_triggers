root_path = '/home/curtislab/Desktop/Mrugank/mgs_stimul/EEG_TMS_triggers';
fname = ['sudo python3 ' root_path '/trigger_send.py &'];
ts = [];
fs = [];
for ii = 1:20
    disp(ii)
    ts = [ts GetSecs];
    system(fname);
    WaitSecs(1);
    fs = [fs GetSecs];
end



