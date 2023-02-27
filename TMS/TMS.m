function [varargout] = TMS(flag, varargin)
%-------------------------------------------------------------------------
% Function that enables communicating with MagVenture TMS machine. The
% following functionality is available:
% OPEN PORT: opens the serial port COM2
%       Usage: s = TMS('Open')
% STATUS: gets the current status on the TMS machine
%       Usage: TMS('Status', s)
% ENABLE TMS: Enables the TMS machine. This can be done manually instead.
%       Usage: TMS('Enable', s)
% AMPLITUDE: Sets the amplitude on the TMS machine.
%       Usage: TMS('Amplitude', s, newAmplitude)
% SEND TRAIN: starts a train of pulses that needs to be set up manually on
%       the TMS machine. Amplitude needs to be set in advance with a
%       separate call. An optinal parameter "time" can be used to control
%       the exact time of TMS delivery.
%       Usage: TMS('Train', s, time)
% PAUSE/GO: Pauses the TMS machine during train sequence and continues.
%       Usage: TMS('Pause', s)
% SET MAIN PAGE: Set to Main page command
%       Usage: TMS('Main', s)
% SET TIMING PAGE: Set to Timing page command
%       Usage: TMS('Timing', s)
% SET PROTOCOL PAGE: Set to Protocol Tool page command
%       Usage: TMS('Protocol', s)
% SEND SINGLE PULSE: sends a single pulse. Amplitude needs to be set in
%       advance with a separate call. An optinal parameter "time" can be
%       used to control the exact time of TMS delivery.
%       Usage: TMS('Single', s, time)
% DISABLE TMS: Disables the TMS machine. This can be done manually instead.
%       Usage: TMS('Disable', s)
% CLOSE PORT: closes the serial port
%       Usage: TMS('Close', s)
%
% Written by Doby Rahnev and Justin Riddle
% Modified by Mrugank Dake (01/22/2023): to adapt to changing ttyUSBx ports
% on Ubuntu
%-------------------------------------------------------------------------


if strcmp(flag,'Open')
    % Opens COM3 port and returns serial port ID
    dev_num = 0;
    devs = dir('/dev/');
    while 1
        dev_name = ['ttyUSB', num2str(dev_num)];
        if any(strcmp({devs.name}, dev_name))
            break
        else
            dev_num = dev_num + 1;
        end
    end
    trigger_id = ['/dev/', dev_name];
    
    s = serial(trigger_id); % Ubuntu serial port
    fopen(s);
    set(s,'Baudrate',38400)
    % set(s,'Timeout',0.001)
    varargout{1} = s;
    fprintf('Serial Port OPEN\n');
    
else
    
    % The serial port has already been opened, and is expected as the first
    % parameter in varargin
    s = varargin{1};
    
    switch flag
        case 'Enable'
            % Enables the TMS machine
            fwrite(s, [254, 3, 2, 1, 0, 139, 255], 'uint8');
            fprintf('TMS machine ENABLED\n');
            
        case 'Main'
            % Switch to Main menu page on the TMS machine
            fwrite(s, [254, 3, 7, 1, 0, 190, 255], 'uint8');
            fprintf('TMS machine set to Main Menu Page\n');
            
        case 'Timing'
            % Switch to Timing menu page on the TMS machine
            fwrite(s, [254, 3, 7, 2, 0, 235, 255], 'uint8');
            fprintf('TMS machine set to Timing Menu Page\n');
            
        case 'Protocol'
            % Switch to Protocol menu page on the TMS machine
            fwrite(s, [254, 3, 7, 7, 0, 20, 255], 'uint8');
            fprintf('TMS machine set to Protocol Tool Page\n');
            
        case 'Amplitude'
            % Sets the amplitude of the TMS machine
            number = varargin{2};
            assert(number >= 0 || number <= 100);
            % Calculate CRC8 for MagVenture
            CRC8_hex = crc8_magVenture(['01' dec2hex(number,2) '00']);
            % Set the amplitude
            fwrite(s, [254, 3, 1, number, 0, hex2dec(CRC8_hex), 255], 'uint8');
        
        case 'Single'
            % Sends a single pulse at current amplitude
            if length(varargin) < 2
                fwrite(s, [254, 3, 3, 1, 0, 32, 255], 'uint8');
            else
                time = varargin{2};
                fwrite(s, [254, 3, 3, 1, 0, 32], 'uint8');
                WaitSecs('UntilTime', time);
                fwrite(s, 255, 'uint8');
            end
            
        case 'Train'
            % Start a train at current amplitude
            if length(varargin) < 2
                fwrite(s, [254, 3, 4, 0, 0, 158, 255], 'uint8');
            else
                time = varargin{2};
                fwrite(s, [254, 3, 4, 0, 0, 158], 'uint8');
                WaitSecs('UntilTime', time);
                fwrite(s, 255, 'uint8');
            end

        case 'Status'
            % Reports back the TMS machine status
            fwrite(s, [254, 1, 5, 63, 255], 'uint8');
            fprintf('FE 0F 05 04 00 04 DB 17 52 00 00 00 00 64 64 01 00 5A FF Status OK\n');
            
        case 'Pause'
            % Pauses the TMS machine in tain sequence
            fwrite(s, [254, 3, 4, 1, 0, 90, 255], 'uint8');
            fprintf('TMS machine PAUSED\n');

        case 'Disable'
            % Disables the TMS machine
            fwrite(s, [254, 3, 2, 0, 0, 79, 255], 'uint8');
            fprintf('TMS machine DISABLED\n');
            
        case 'Close'
            % Closes the serial port
            fclose(s);
            delete(s);
            clear s;
            fprintf('Serial Port CLOSED\n');
    end
end
end