function [f_original, eegspec_original] = powerSpectrum(channel, fs)
eeg = channel;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
%eegspec_original = 20*log10(abs(eegfft)/maxft);
eegspec_original = eegfft;
end