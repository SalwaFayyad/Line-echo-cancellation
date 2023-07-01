close all;
clear all;
clc;

load('path.mat');
load('css.mat');

far_end_signal = repmat(css, 1, 10); % Repeat CSS data for 10 blocks
echo_signal = filter(path, 1, far_end_signal);

filter_length = 128; % Number of filter taps
step_size = 1e-6; % LMS step size
adapt_filter = zeros(filter_length, 1); % Initialize adaptive filter coefficients
delayedFarEndSignal = zeros(filter_length, 1);  

% Initialize error signal with the size of far_end_signal
error_signal = zeros(size(far_end_signal));
estimatedEchoPath = zeros(size(far_end_signal));

for n = 1:length(far_end_signal)
    farEndSample = far_end_signal(n);
    echoSample = echo_signal(n);
    
    y = adapt_filter' * delayedFarEndSignal; % Output of adaptive filter
    error = echoSample - y; % Error signal
    
    adapt_filter = adapt_filter + step_size * conj(delayedFarEndSignal) * error; % Update filter weights
    
    error_signal(n) = error; % Store error signal
    estimatedEchoPath(n) = adapt_filter' * delayedFarEndSignal; % Estimate of echo path
    
    % Shift the delayedFarEndSignal by 1 sample
    delayedFarEndSignal = [farEndSample; delayedFarEndSignal(1:end-1)];
end

% Compute the frequency response of the estimated FIR channel
[H_est, w_est] = freqz(adapt_filter, 1, length(adapt_filter));

% Compute the frequency response of the given FIR system (Path)
[H_path, w_path] = freqz(path, 1, length(path));

% Plot the amplitude response
figure;
subplot(2, 1, 1);
plot(w_est/pi, 20*log10(abs(H_est)));
hold on;
plot(w_path/pi, 20*log10(abs(H_path)));
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
