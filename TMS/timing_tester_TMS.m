clear; close all; clc;
% Add Psychtoolbox
addpath(genpath('/usr/share/psychtoolbox-3'))

s = TMS('Open')
TMS('Enable', s);
%TMS('Main', s);
TMS('Timing', s);
TMS('Amplitude', s, 33);
WaitSecs(2);
startstamps = [];
endstamps = [];
iters = 10;
for i = 1:iters
    t_now = GetSecs;
    startstamps = [startstamps, t_now];
    %TMS('Single', s);
    TMS('Train', s);
    WaitSecs(2 - (GetSecs - t_now));
    endstamps = [endstamps, GetSecs];
end

TMS('Disable', s);
TMS('Close', s);
delay = diff(startstamps);