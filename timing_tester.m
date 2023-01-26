clear; close all; clc;
root_path = '/home/curtislab/Desktop/Mrugank/mgs_stimul/EEG_TMS_triggers';

%system(['sudo python3 ' root_path '/trigger_send.py'])
% s = TMS('Open')
% TMS('Enable', s);
% TMS('Main', s);
% TMS('Timing', s);
% TMS('Amplitude', s, 33);
startstamps = [];
endstamps = [];
iters = 10;
for i = 1:iters
    startstamps = [startstamps, GetSecs];
    start_TMS_stim();
    %TMS('Single', s);
    %pause(1);
    endstamps = [endstamps, GetSecs];
end

TMS('Disable', s);
TMS('Close', s);