%%% Author: Aditya Jain %%%%%%%%%%%%%%%%%
%%% Topic: Ambiguity Diagram %%%
%%% Date: 16th February, 2018 %%%%%%%%%%

clc
clear 
close all

%% Variable Declaration

% Processing is in IF band
fIf = 2e+6;    % frequency in IF band
c = 3e+8;      % speed of light
bw = (1e+6)/30;   % bandwidth
delr = c/(2*bw);   % range resolution
pw = 1/bw;         % pulse width
Rmax = 10*delr;   % max unambiguous range
PRI = (2*Rmax)/c;  % pulse Repetition Interval
PRF = 1/PRI;       % pulse Repetition Frequency
fs = 6*fIf;        % sampling frequency
lambda = 0.03;      % wavelength
fdmax = fs/2;      % max doppler
vmax = (lambda*fdmax)/2; % max velocity that can be measured by the radar
CPI = 1*PRI;        % coherent processing interval
delf = 1/CPI;       % frequency increment
delt = 1/fs;        % time increment
N = round(CPI/delt); % total samples
fd = -fs/2:delf:(fs/2-delf); % frequency range

% Target Parameters
ro = Rmax/2;    % target distance
vo = vmax/2;    % target velocity
fdo = (2*vo)/lambda; % doppler frequency shift
to = (2*ro)/c;  % time shift

%% Ambiguity diagram math here

nw = (pw)/delt;                       % width of the rectangular pulse
xaxis = -(N-1)*delt:delt:(N-1)*delt;  % x-axis
Stx = zeros(1, N);

% rect function multiplied with the real signal
for n = 1:N
    if n < nw
        Stx(1,n) = exp(1i*2*pi*fIf*(n-1)*delt);        
    end    
end


Srx = zeros(1, N);
No = ((2*ro)/c)/delt;    % mapping the shift to the discrete axis
% calculating the received signal
for n = 1:N
    if (n > No-nw/2) && (n < No+nw/2)  
        Srx(1,n) = exp(1i*2*pi*(fIf + fdo)*(n-1)*delt);
    end    
end

faxis = -fs/2:delf:(fs/2-delf);   % this has N points

%% Calculating the chi-matrix here

chi = zeros(N, 2*N-1);
tau = 0:delt:CPI-delt;
for n=1:N
%     S = Stx.*cos(2*pi*faxis(n)*tau);
    S = Stx.*exp(-1i*2*pi*faxis(n)*tau);
    chi(n,:) = xcorr(S, Srx);    
end

% Plotting
taxis = -CPI:delt:(CPI-delt);     % time axis
chi_db = 10*log10(abs(chi));
cmax = max(max(chi_db));
imagesc(taxis, faxis, chi_db,[cmax-30 cmax]);
% imagesc(taxis, faxis, chi_db)
xlabel('Range')
ylabel('Frequency')
title('Ambiguity Diagram')
