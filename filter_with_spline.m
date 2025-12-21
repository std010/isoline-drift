step = 50;
signal = load('ecg_polorised.txt');

r_peaks = find(signal(:,3) == 1);

x_points = [];
y_points = [];

for i = 1:length(r_peaks)
    current_r = r_peaks(i);
    if current_r > step
        point_index = current_r - step;
        x_points = [x_points; point_index];
        y_points = [y_points; signal(point_index, 2)];
    end
end

% Граничные точки
x_points = [1; x_points; length(signal)];
y_points = [signal(1, 2); y_points; signal(end, 2)];

% Сплайн
full_range = 1:length(signal);
spline_curve = interp1(x_points, y_points, full_range, 'spline');


new_signal = signal;
new_signal(:,2) = new_signal(:,2) - spline_curve';


dlmwrite('ecg_filtered_with_wpline.txt', new_signal, 'delimiter', '\t', 'precision', 6);



% Исходный сигнал и сплайн
figure('Position', [100, 100, 1000, 400]);
subplot(1,2,1);
plot(signal(:,1), signal(:,2), 'b', 'LineWidth', 1);
hold on;
plot(signal(:,1), spline_curve, 'r-', 'LineWidth', 2);
plot(signal(x_points_unique,1), y_points_unique, 'mo', 'MarkerSize', 6);
title('Исходный сигнал и сплайн');
xlabel('Время');
ylabel('Амплитуда');
legend('Сигнал', 'Сплайн', 'Точки', 'Location', 'best');
grid on;

% Новый сигнал
subplot(1,2,2);
plot(new_signal(:,1), new_signal(:,2), 'g', 'LineWidth', 1.5);
title('Сигнал после коррекции');
xlabel('Время');
ylabel('Амплитуда');
grid on;
