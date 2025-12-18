clear all
close all

E=load('ecg_original_with_rpeaks.txt');

figure('Name','ECG','NumberTitle','off');

subplot(2,1,1)
plot(E(:,2))
title('ECG Signal')
ylim([1900 2600])
 
subplot(2,1,2)
plot(E(:,3))
title('ECG RR')
ylim([-5 5])