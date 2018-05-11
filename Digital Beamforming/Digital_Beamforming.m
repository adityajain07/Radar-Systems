%%% Author: Aditya Jain %%%%%%%%%%%%%%%%%
%%% Topic: Digital Beamforming %%%
%%% Date: 16th March, 2018 %%%%%%%%%%
%%% About: This is basically used to calculate the direction of arrival
%%% (DOA) of the signal

clc
clear
close all

%% Variable Declaration
Atgt = 1;   % strength of the target signal
Qtgt = 30;  % azimuth of the tar
N = 50;     % no of elements in the phased array
d = 0.3;    % spacing between the elements in m
fc = 3e+8;  % carrier frequency in Hz
c = 3e+8;   % speed of light
lambda = c/fc;  % wavelength
k = (2*pi)/lambda;  % propagation constant
Qmin = -90;     % minimum angle to search
Qmax = 90;      % maximum angle to search
delQ = 1;       % resolution between min to max

%% Simulating the received signal
y = zeros(1,N);

for n = 1:N
    y(n) = exp(-1i*(n-1)*k*d*sind(Qtgt));
    
end

%% Array Processing
theta = Qmin:delQ:Qmax;       % sweep of angles to check
AF = zeros(1,length(theta));  % initialising the array factor
w = zeros(1,N);               % initialising the weigths
Nlength = 0:1:N-1;

for i = 1:length(theta)
    w = exp(1i.*Nlength*k*d*sind(theta(i)));
    
    AF(i) = sum(w.*y);
end

plot(theta, abs(AF))
xlabel('Angle in degrees')
ylabel('Array Factor')
title('Digital Beamforming')

%%