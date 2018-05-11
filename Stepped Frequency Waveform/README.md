# About
This project uses a stepped-frequency waveform as the transmitted signal to detect a target. The steps of the process are enumerated below:
1. Signal is received in the frequency domain
1. Applying windowing (hamming function in this code) to reduce the strength of grating lobes
1. Applying Inverse Fourier Transform (IFFT) to get range
1. Applying IFFT-shift to get range from -Rmax/2 to Rmax/2
