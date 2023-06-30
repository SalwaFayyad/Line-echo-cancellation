load('path.mat');

subplot(2, 1, 1);
plot(path);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Response of Echo Path');

subplot(2, 1, 2);
[H, w] = freqz(path, 1, length(path));
magnitude_dB = 20 * log10(abs(H)); % Compute magnitude in dB

plot(w/pi*4000, magnitude_dB);
xlabel('Frequency (\times \pi radians/sample)');
ylabel('Magnitude (dB)');
title('Frequency Response (dB)');
