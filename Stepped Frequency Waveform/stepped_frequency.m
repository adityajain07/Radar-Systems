%%% Author: Aditya Jain %%%%%%%%%%%%%%%%%
%%% Topic: Stepped Frequency Waveform %%%
%%% Date: 16th March, 2018 %%%%%%%%%%

clc
clear
close all

%% Variable Declaration
fmin = 2.5e+9;     % min frequency
fmax = 3.5e+9;     % max frequency
bw = fmax - fmin;    % bandwidth of the signal
fstep = 1500;      % frequency step in Hz
A = 10;            % Magnitude (RCS of the target)
c = 3e+8;              % speed of light
Rmax = c/(2*fstep);    % Max unambiguous detectable range
target = Rmax/4;       % location of the target
delr = c/(2*bw);       % range resolution

% Defining the axis
faxis = fmin:fstep:fmax-fstep;    % frequency axis
raxis = -Rmax/2:delr:Rmax/2-delr; % range axis

SrxF = A*exp(-1j*2*pi*faxis*2*target/c);  % Received Signal in frequency domain

%% Windowing: Hamming function
len = size(faxis);
w = hamming(len(2))';

SrxW = SrxF.*w;   % windowed received signal in frequency domain  

%% IFFT
SrxT = ifftshift(ifft(SrxW));   % using ifftshift to get result from -Rmax/2 to Rmax/2

plot(raxis,20*log10(abs(SrxT)))
title('Stepped Frequency')
xlabel('Range')
ylabel('Signal Strength in Volts (in dB)')
