# About
This project uses a stepped-frequency waveform as the transmitted signal to detect a target. 

## Process
The steps of the process are enumerated below:
1. Signal is received in the frequency domain
1. Applying windowing (hamming function in this code) to reduce the strength of grating lobes
1. Applying Inverse Fast Fourier Transform (IFFT) to get range
1. Applying IFFT-shift to get range from -Rmax/2 to Rmax/2

Below is the plot after applying all the above techniques (the received signal is simulated to have the target at a distance of 25km):
![alt text](https://github.com/adityajain07/Radar-Systems/blob/master/Stepped%20Frequency%20Waveform/SteppedFrequency_new.png)
