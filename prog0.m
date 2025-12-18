clear all
close all

E=load('ecg_original_with_rpeaks.txt');

figure('Name','ECG','NumberTitle','off');

plot(E(:,:));
title('ECG Signal')

 
