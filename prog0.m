clear all
close all

data=load('ECG_with_Rpeaks_200Hz.txt');

time = data(:,1);           % Время
amplitude = data(:,2);      % Амплитуда сигнала

g=Filterbtw;
filtered_signal = filter(g, amplitude);

figure('Name','ECG','NumberTitle','off');

    subplot(2,1,1);
    plot(time, amplitude);
    title('Оригинальный ЭКГ сигнал');
    xlabel('Время (с)');
    ylabel('Амплитуда');
    grid on;
    xlim([0 10]);
    ylim([-0.6 0.6]);

    subplot(2,1,2);
    plot(time, filtered_signal);
    title('Отфильтрованный ЭКГ сигнал (Highpass)');
    xlabel('Время (с)');
    ylabel('Амплитуда');
    grid on;
    xlim([0 10]);
    ylim([-0.6 0.6]);


 
