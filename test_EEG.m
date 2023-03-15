root_path = '/home/curtislab/Desktop/Mrugank/mgs_stimul/EEG_TMS_triggers';
fname = ['sudo python3 ' root_path '/EEG/eegflag0.py &'];
system(fname);
ts = [];
fs = [];
for ii = 1:10
    disp(ii)
    ts = [ts GetSecs];
    fname = ['sudo python3 ' root_path '/EEG/eegflag' num2str(ii) '.py &']
    system(fname);
    WaitSecs(1);
    fs = [fs GetSecs];
end



