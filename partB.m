%Salwa Fayyad 1200430 , Sondos Farrah 1200905 , Katya Kobari 1201478
close all;
clear all;
clc;

fs = 8000;
load('path.mat');
% Load the data from css.mat file
load('css.mat'); % Assuming css.mat is in the current directory
subplot(2, 2, 1);
plot(css);
xlabel('Time');
ylabel('Amplitude');
title('Composite Source Siganl');

subplot(2, 2, 2);
[psd, freq] = pwelch(css, [], [], [], fs);
plot(freq, 10*log10(psd),'r');
title('Power Spectral Density ');
xlabel('Frequency (Hz)');
ylabel('Power (dB)');

%Far-end signal
subplot(2, 2, 3);
Xc= [css css css css css];
yy = linspace(0, (length(Xc)-1)*(1000/fs), length(Xc));
length(Xc)
length(yy)
plot(Xc,'g');
title('Far-end Signal');
xlabel('Time');
ylabel('Amplitude');


subplot(2, 2, 4);
y = conv(path,Xc);
plot(y,'m');
title('Echo Signal');
xlabel('Time');
ylabel('Amplitude');


