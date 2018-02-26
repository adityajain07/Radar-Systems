%%% Author: Aditya Jain %%%%%%%%%%%%%%%%%
%%% Topic: Auto and Cross-Correlation in Radar %%%
%%% Date: 13th February, 2018 %%%%%%%%%%

clc
clear 
close all

%%

f = 1e+7;        % frequency
fs = 5e+7;        % sampling frequency
delt = 1/fs;      % sampling time 
pw = 10/f;        % pulse width
nw = (pw)/delt;  % width of the rectangular pulse on the discrete axis
N = 10*nw;       % total points to be sampled 
c = 3e+8;        % speed of light
xaxis = -(N-1)*delt:delt:(N-1)*delt;  % x-axis

%% Auto-Correlation of the input signal
Stx = zeros(1, N);

% rect function multiplied with the complex signal
for n = 1:N
    if n < nw
        Stx(1,n) = exp(1i*2*pi*f*(n-1)*delt);        
    end    
end

Sout = xcorr(Stx,Stx);
figure
plot(xaxis, Sout)
title('Auto-Correlation')

%% Cross-Correlation of Txed and Rxed Signal
Srx = zeros(1, N);
hn = zeros(1, N);
r = 1200;             % target is at 1200m from the monostatic radar
No = ((2*r)/c)/delt;  % calculating the shift in rxed signal and converting to discrete scale

% the shifted received signal
for n = 1:N
    if (n > No-nw/2) && (n < No+nw/2)
        Srx(1,n) = exp(1i*2*pi*f*((n-1)*delt-No));
    end    
end

Soutcross = xcorr(Stx,Srx);
figure
plot(xaxis, Soutcross)
title('Cross-Correlation')
