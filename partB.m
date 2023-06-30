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
title('css');

subplot(2, 2, 2);
nfft = 2^nextpow2(length(css));
Pxx = abs(fft(css,nfft)).^2/length(css)/fs;
Hpsd = dspdata.psd(Pxx(1:length(Pxx)/2),'Fs',fs);  
plot(Hpsd);

subplot(2, 2, 3);
Xc= [css css css css css];
plot(Xc);

subplot(2, 2, 4);
y = conv(path,Xc);
plot(y);
