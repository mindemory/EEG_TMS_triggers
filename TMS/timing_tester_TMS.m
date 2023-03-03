clear; close all; clc;
% Add Psychtoolbox
addpath(genpath('/usr/share/psychtoolbox-3'))

s = TMS('Open')
TMS('Enable', s);
TMS('Main', s);
TMS('Timing', s);
TMS('Amplitude', s, 33);
startstamps = [];
endstamps = [];
iters = 10;
for i = 1:iters
    startstamps = [startstamps, GetSecs];
    %TMS('Single', s);
    TMS('Train', s);
    
    endstamps = [endstamps, GetSecs];
    
    WaitSecs(2);
    %pause(1);
end

TMS('Disable', s);
TMS('Close', s);
delay = diff(startstamps);