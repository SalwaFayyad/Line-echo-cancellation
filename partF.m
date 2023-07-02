%Salwa Fayyad 1200430 , Sondos Farrah 1200905 , Katya Kobari 1201478
close all;
clear all;
clc;

load('path.mat');
load('css.mat');

farEnd = repmat(css, 1, 10); 
echoSignal = filter(path, 1, farEnd);

filter_length = 128; 
step_size = 1e-6; 
adaptiveFilter = zeros(filter_length, 1); 
delayedFarEnd = zeros(filter_length, 1);  

error_signal = zeros(size(farEnd));
estimatedEchoPath = zeros(size(farEnd));

for n = 1:length(farEnd)
    farEndSample = farEnd(n);
    echoSample = echoSignal(n);
    
    y = adaptiveFilter' * delayedFarEnd; 
    error = echoSample - y; % Error signal
    
    adaptiveFilter = adaptiveFilter + step_size * conj(delayedFarEnd) * error; % Update filter weights
    
    error_signal(n) = error; % Store error signal
    estimatedEchoPath(n) = adaptiveFilter' * delayedFarEnd; % Estimate of echo path
    
    delayedFarEnd = [farEndSample; delayedFarEnd(1:end-1)];
end

% Compute the frequency response of the estimated FIR channel
[H_est, w_est] = freqz(adaptiveFilter, 1, length(adaptiveFilter));

% Compute the frequency response of the given FIR system (Path)
[H_path, w_path] = freqz(path, 1, length(path));

% Plot the amplitude response
figure;
subplot(2, 1, 1);
plot(w_est/pi, 20*log10(abs(H_est)),'LineWidth',2,Color="#77AC30");
hold on;
plot(w_path/pi, 20*log10(abs(H_path)),'LineWidth',2,color="#7E2F8E");
hold off;
title('Amplitude Response');
xlabel('Normalized Frequency (*pi rad/sample)');
ylabel('Amplitude (dB)');
legend('Estimated FIR Channel', 'FIR System (Path)');

% Plot the phase response
subplot(2, 1, 2);
plot(w_est/pi, unwrap(angle(H_est)),'LineWidth',2,Color="#77AC30");
hold on;
plot(w_path/pi, unwrap(angle(H_path)),'LineWidth',2,color="#7E2F8E");
hold off;
title('Phase Response');
xlabel('Normalized Frequency (*pi rad/sample)');
ylabel('Phase (rad)');
legend('Estimated FIR Channel', 'FIR System (Path)');
