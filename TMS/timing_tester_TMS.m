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
iters = 100;
for i = 1:iters
    startstamps = [startstamps, GetSecs];
    TMS('Single', s);
    %TMS('Train', s);
    WaitSecs(0.15);
    pause(1);
    endstamps = [endstamps, GetSecs];
end

TMS('Disable', s);
TMS('Close', s);
delay = diff(startstamps);