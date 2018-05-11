%%% Author: Aditya Jain %%%%%%%%%%%%%%%%%
%%% Topic: Linear Frequency Modulated (LFM) Signal, Up-chirp %%%
%%% Date: 22nd February, 2018 %%%%%%%%%%

clc
clear 
close all

%% Variable Declaration

T = 1e-6;   % PRI
k = 5e+12;  % the constant k
N = 1000;   % total no of points on the axis
delt = T/N; % sampling time
xaxis = -(2*N-1)*delt:delt:(2*N-1)*delt;  % x-axis
c = 3e+8;   % speed of light
r = 100;    % distance from the target

%% Input Signal

Stx = zeros(1, 2*N);
% rect function multiplied with the exponential function
for n = 1:2*N   
    if n < N+1
        Stx(1,n) = exp(-1i*pi*k*(((n-1)*delt)^2));       
    end
end

%% Received Signal
timeShift = (2*r)/c;       % time shift in linear scale
timeShiftDis = round(timeShift/delt);  % time shift in discrete scale

Srx = zeros(1, 2*N);
for n = 1:2*N     % the time shift in rect function won't be affected because signal is always on
    if n>timeShiftDis && n<N+timeShiftDis+1
        Srx(1,n) = exp(-1i*pi*k*(((n-1)*delt - timeShift)^2));     
    end
end

%% Plotting

Soutcross = abs(xcorr(Stx,Srx));
figure
plot(xaxis, Soutcross)
xlabel('time in discrete scale')
ylabel('Signal Strength')
title('Matched Filter (LFM) (Aditya Jain) ')
