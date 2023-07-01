%Salwa Fayyad 1200430 , Sondos Farrah 1200905 , Katya Kobari 1201478
load('path.mat');

subplot(2, 1, 1);
plot(path,'m','LineWidth',2);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Response of Echo Path');

subplot(2, 1, 2);
[H, w] = freqz(path, 1, length(path));
magnitude_dB = 20 * log10(abs(H)); % Compute magnitude in dB

plot(w/pi*4000, magnitude_dB,'c','LineWidth',2);
xlabel('Frequency');
ylabel('Amplitude (dB)');
title('Frequency Response ');
