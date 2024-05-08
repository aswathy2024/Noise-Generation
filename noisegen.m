% Parameters
Fs = 1000;        % Sampling frequency
T = 1/Fs;         % Sampling period
L = 1000;         % Length of signal
t = (0:L-1)*T;    % Time vector

% Generate white Gaussian noise
mu = 0;           % Mean of noise
sigma = 1;        % Standard deviation of noise
noise = mu + sigma * randn(size(t));

% Plot the noise signal
subplot(3,1,1);
plot(t, noise);
title('White Gaussian Noise');
xlabel('Time (s)');
ylabel('Amplitude');

% Compute the Fourier transform
NFFT = 2^nextpow2(L);       % Next power of 2 from length of signal
Y = fft(noise,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum of the original noise
subplot(3,1,2);
plot(f,2*abs(Y(1:NFFT/2+1)));
title('Single-Sided Amplitude Spectrum of Original Noise');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');

% Design a bandpass FIR filter
lowFreq = 200;   % Lower cutoff frequency
highFreq = 300;  % Upper cutoff frequency
order = 50;      % Filter order
b = fir1(order, [lowFreq highFreq]/(Fs/2), 'bandpass');

% Apply the filter to the noise signal
filteredNoise = filter(b, 1, noise);

% Plot the filtered noise signal
subplot(3,1,3);
plot(t, filteredNoise);
title('Filtered Noise (Bandpass FIR Filter)');
xlabel('Time (s)');
ylabel('Amplitude');

% Compute the Fourier transform of the filtered noise
filteredY = fft(filteredNoise, NFFT)/L;
filteredF = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum of the filtered noise
figure;
plot(filteredF, 2*abs(filteredY(1:NFFT/2+1)));
title('Single-Sided Amplitude Spectrum of Filtered Noise');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
xlim([0 Fs/2]);


