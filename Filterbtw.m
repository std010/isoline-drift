function Hd = Filterbtw
Fs = 1000;  % Sampling Frequency
N  = 1;  % Order
Fc = 1;  % Cutoff Frequency
h  = fdesign.highpass('N,F3dB', N, Fc, Fs);
Hd = design(h, 'butter');
