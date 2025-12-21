% Загружаем три версии сигнала
orig = load('ecg_original_with_rpeaks.txt');
noisy = load('ecg_polorised.txt');
filt = load('ecg_filtered_with_wpline.txt');

sig_orig = orig(:,2);
sig_noisy = noisy(:,2);
sig_filt = filt(:,2);

Fs = 1000;
N = length(sig_orig);
f = (0:N/2)*Fs/N;

% БПФ
spec_orig = abs(fft(sig_orig)/N);
spec_noisy = abs(fft(sig_noisy)/N);
spec_filt = abs(fft(sig_filt)/N);


spec_orig = spec_orig(1:N/2+1);
spec_noisy = spec_noisy(1:N/2+1);
spec_filt = spec_filt(1:N/2+1);


H = spec_filt ./ spec_noisy;
H(isinf(H) | isnan(H)) = 0; % Чиним деление на ноль

% Ошибка между отфильтрованным и исходным сигналом
err_time = sqrt(mean((sig_filt - sig_orig).^2));
err_freq = sqrt(mean((spec_filt - spec_orig).^2));


fprintf('Сравнение сигналов:\n');
fprintf('Частота дискретизации: %d Гц\n', Fs);
fprintf('Длина записи: %.1f секунд\n', N/Fs);
fprintf('Ошибка во времени: %.6f\n', err_time);
fprintf('Ошибка в частоте: %.6f\n', err_freq);

% Визуализация
figure('Position', [100, 100, 1200, 800]);

% 1. Все спектры на одном графике
subplot(2,2,1);
semilogy(f, spec_orig, 'b', 'LineWidth', 1.5);
hold on;
semilogy(f, spec_noisy, 'r', 'LineWidth', 1);
semilogy(f, spec_filt, 'g', 'LineWidth', 1.5);
xlim([0, 10]);
title('Спектры сигналов');
xlabel('Частота (Гц)');
ylabel('Амплитуда (лог)');
legend('Исходный', 'С шумом', 'После фильтра', 'Location', 'best');
grid on;

% 2. Низкие частоты
subplot(2,2,2);
plot(f, spec_orig, 'b', 'LineWidth', 1.5);
hold on;
plot(f, spec_noisy, 'r', 'LineWidth', 1);
plot(f, spec_filt, 'g', 'LineWidth', 1.5);
xlim([0, 1]);
title('Низкие частоты (0-1 Гц)');
xlabel('Частота (Гц)');
ylabel('Амплитуда');
legend('Исходный', 'С шумом', 'После фильтра', 'Location', 'best');
grid on;

% 3. Передаточная функци
subplot(2,2,3);
plot(f, abs(H), 'm', 'LineWidth', 1.5);
xlim([0, 10]);
title('Характеристика фильтрации |H(f)|');
xlabel('Частота (Гц)');
ylabel('Коэффициент передачи');
grid on;

% 4. Разница между спектрами
subplot(2,2,4);
plot(f, abs(spec_filt - spec_orig), 'r', 'LineWidth', 1.5);
xlim([0, 10]);
title('Ошибка в частотной области');
xlabel('Частота (Гц)');
ylabel('Ошибка');
grid on;

figure('Position', [100, 550, 1200, 300]);
start_idx = 1;
end_idx = min(5000, N); % первые 5 секунд

plot(orig(start_idx:end_idx,1), sig_orig(start_idx:end_idx), 'b');
hold on;
plot(noisy(start_idx:end_idx,1), sig_noisy(start_idx:end_idx), 'r');
plot(filt(start_idx:end_idx,1), sig_filt(start_idx:end_idx), 'g');
title('Сигналы (первые 5 секунд)');
xlabel('Время (с)');
ylabel('Амплитуда');
legend('Исходный', 'С шумом', 'После фильтра', 'Location', 'best');
grid on;

fprintf('\nСредние значения:\n');
fprintf('Исходный: %.6f\n', mean(sig_orig));
fprintf('С шумом: %.6f\n', mean(sig_noisy));
fprintf('После фильтра: %.6f\n', mean(sig_filt));

fprintf('\nПостоянная составляющая (0 Гц):\n');
fprintf('Исходный: %.6f\n', spec_orig(1));
fprintf('С шумом: %.6f\n', spec_noisy(1));
fprintf('После фильтра: %.6f\n', spec_filt(1));

if spec_noisy(1) > 0
    reduction = (1 - spec_filt(1)/spec_noisy(1)) * 100;
    fprintf('Уменьшение постоянной составляющей: %.1f%%\n', reduction);
end
