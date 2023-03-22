%% Test one flag = flag 0
fname = ['sudo python3 ' root_path '/EEG/eegflag0.py &'];
system(fname);

%% Test running all flags
ts = [];
fs = [];
for ff = 1:15
    ii = 0
    disp(ii)
    ts = [ts GetSecs];
    fname = ['sudo python3 ' root_path '/EEG/eegflag' num2str(ii) '.py &']
    system(fname);
    WaitSecs(1);
    fs = [fs GetSecs];
end