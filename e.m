% Load CSS data and echo path
load('css.mat');
load('path.mat');

% Apply NLMS algorithm to train the adaptive filter
filter_length = 128;
adapt_filter = zeros(filter_length, 1);
mu = 0.25;
step_size = 6e-10;
desired_signal = conv(path, css);
error_signal = zeros(length(css), 1);

for n = filter_length:length(css)
    x = css(n:-1:n-filter_length+1);
    y = adapt_filter.' * x.';
    error = desired_signal(n) - y;
    adapt_filter = adapt_filter + (step_size * x.' * error) / (norm(x)^2 + mu);
    error_signal(n) = error;
end

% Compute the frequency response of the estimated FIR channel
[H_est, w_est] = freqz(adapt_filter);

% Compute the frequency response of the given FIR system (Path)
[H_path, w_path] = freqz(path);

% Plot the amplitude response
figure;
subplot(2, 1, 1);
plot(w_est/pi, abs(H_est));
hold on;
plot(w_path/pi, abs(H_path));
hold off;
title('Amplitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
legend('Estimated FIR Channel', 'Given FIR System (Path)');

% Plot the phase response
subplot(2, 1, 2);
plot(w_est/pi, unwrap(angle(H_est)));
hold on;
plot(w_path/pi, unwrap(angle(H_path)));
hold off;
title('Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (rad)');
legend('Estimated FIR Channel', 'Given FIR System (Path)');
