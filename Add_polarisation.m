E=load('ecg_original_with_rpeaks.txt');
f = 0.3;
t_sec=E(:,1);
amp_uV = 100;
noise = amp_uV * sin(2 * pi * f * t_sec);
noisy_signal = E(:,2)+noise;
new_file = E;
new_file(:,2) = noisy_signal;
dlmwrite('ecg_polorised.txt', new_file, 'delimiter', '\t', 'precision', 6);