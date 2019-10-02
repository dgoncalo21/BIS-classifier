clc, clear all, close all
% diz ch4 mas no nosso ICA novo foi o ch3
load('afterIcaAfterEscolhidoJunto.mat');
load('tempoJunto.mat');
ch1 = newMatrix(1,:);
ch2 = newMatrix(2,:);
ch4 = newMatrix(3,:);


%% Remove outliers
ch1(find(ch1>2.5))= 2.5;
ch1(find(ch1<-2.5))= -2.5;
ch2(find(ch2>2.5))= 2.5;
ch2(find(ch2<-2.5))= -2.5;
ch4(find(ch4>4))= 4;
ch4(find(ch4<-4))= 4;

%% Plot original
figure
plot(timeFp1, ch1)
title('Channel 1')
figure
plot(timeFp1, ch2)
title('Channel 2')
figure
plot(timeFp1, ch4)
title('Channel 3')

%% Starting Filters
%ch1
eeg = ch1;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel1');
axis tight;
%ylim([-100,0])

%ch2
eeg = ch2;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel2');
axis tight;
%ylim([-100,0])

%ch4
eeg = ch4;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG channel3');
axis tight;
%ylim([-100,0])



%% Notch Filter

b_comb=conv([1 -cos(2*pi*50/fs)-1j*sin(2*pi*50/fs)],[1 -cos(2*pi*50/fs)+1j*sin(2*pi*50/fs)]);


a_comb=[1];
norm=sum(b_comb);
b_comb=b_comb/norm;

filterCh1 = filter(b_comb,a_comb,ch1);

%ch1Filter
eeg = filterCh1;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the filtered EEG Channel1');
axis tight;
%ylim([-100,0])



%% High Pass
% derivative pole z=0.98

b_high=[1 -1];
a_high=[1 -0.98];

ch1HighPass = filter(b_high, a_high, ch1);
ch2HighPass = filter(b_high, a_high, ch2);
ch4HighPass = filter(b_high, a_high, ch4);

%ch1
eeg = ch1HighPass;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel1');
axis tight;
%ylim([-100,0])


%ch2
eeg = ch2HighPass;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel2');
axis tight;
%ylim([-100,0])


%ch4
eeg = ch4HighPass;
fs=256;
t=[1:length(eeg)]/fs;

eegfft = fft(eeg);
ff= fix(length(eeg)/2) + 1;
maxft = max(abs(eegfft));
f_original = [1:ff]*fs/length(eeg);
eegspec_original = 20*log10(abs(eegfft)/maxft);

figure
plot(f_original,eegspec_original(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG channel3');
axis tight;
%ylim([-100,0])


%% Low Pass
[b_low1,a_low1] = butter(1, 45/(fs/2));
ch1LowPass1 = filter(b_low1, a_low1, ch1);
ch2LowPass1 = filter(b_low1, a_low1, ch2);
ch4LowPass1 = filter(b_low1, a_low1, ch4);


[b_low2,a_low2] = butter(2, 45/(fs/2));
ch1LowPass2 = filter(b_low2, a_low2, ch1);
ch2LowPass2 = filter(b_low2, a_low2, ch2);
ch4LowPass2 = filter(b_low2, a_low2, ch4);


[b_low3,a_low3] = butter(10, 45/(fs/2));
ch1LowPass3 = filter(b_low3, a_low3, ch1);
ch2LowPass3 = filter(b_low3, a_low3, ch2);
ch4LowPass3 = filter(b_low3, a_low3, ch4);

[ch1LowPass1PS_fo, ch1LowPass1PS_eegspec] = powerSpectrum(ch1LowPass1, 256);
[ch1LowPass2PS_fo, ch1LowPass2PS_eegspec] = powerSpectrum(ch1LowPass2, 256);
[ch1LowPass3PS_fo, ch1LowPass3PS_eegspec] = powerSpectrum(ch1LowPass3, 256);

[ch2LowPass1PS_fo, ch2LowPass1PS_eegspec] = powerSpectrum(ch2LowPass1, 256);
[ch2LowPass2PS_fo, ch2LowPass2PS_eegspec] = powerSpectrum(ch2LowPass2, 256);
[ch2LowPass3PS_fo, ch2LowPass3PS_eegspec] = powerSpectrum(ch2LowPass3, 256);

[ch4LowPass1PS_fo, ch4LowPass1PS_eegspec] = powerSpectrum(ch4LowPass1, 256);
[ch4LowPass2PS_fo, ch4LowPass2PS_eegspec] = powerSpectrum(ch4LowPass2, 256);
[ch4LowPass3PS_fo, ch4LowPass3PS_eegspec] = powerSpectrum(ch4LowPass3, 256);


%ch1 Butter
figure
subplot 311
plot(ch1LowPass1PS_fo,ch1LowPass1PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel1, order1');
axis tight;
%ylim([-100,0])

subplot 312
plot(ch1LowPass2PS_fo,ch1LowPass2PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel1, order2');
axis tight;
%ylim([-100,0])

subplot 313
plot(ch1LowPass3PS_fo,ch1LowPass3PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel1, order10');
axis tight;
%ylim([-100,0])

%ch2 Butter
figure
subplot 311
plot(ch2LowPass1PS_fo,ch2LowPass1PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel2, order1');
axis tight;
%ylim([-100,0])

subplot 312
plot(ch2LowPass2PS_fo,ch2LowPass2PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel2, order2');
axis tight;
%ylim([-100,0])

subplot 313
plot(ch2LowPass3PS_fo,ch2LowPass3PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG Channel2, order10');
axis tight;
%ylim([-100,0])


%ch4 Butter
figure
subplot 311
plot(ch4LowPass1PS_fo,ch4LowPass1PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG channel3, order1');
axis tight;
%ylim([-100,0]);

subplot 312
plot(ch4LowPass2PS_fo,ch4LowPass2PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG channel3, order2');
axis tight;
%ylim([-100,0]);

subplot 313
plot(ch4LowPass3PS_fo,ch4LowPass3PS_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Magnitude Spectrum (dB)');
title('Spectrum of the EEG channel3, order10');
axis tight;
%ylim([-100,0]);

%% Remove 0-0.5hz

load('newFilter.mat');
bDesign = d1.Coefficients;

fc=0.55;% cut off frequency
fn=256/2; %nyquivst frequency = sample frequency/2;
order = 5; %6th order filter, high pass
[bStart, aStart]=butter(order,(fc/fn),'high');

%% Joining filters

%bFinal = conv(conv(b_high, b_low3), bDesign);
%bFinalCh1 = conv(conv(conv(b_high, b_low3), b_comb),bDesign);
%aFinal = conv(a_high, a_low3);
%aFinalCh1 = conv(conv(a_high, a_low3), a_comb);

bFinal = conv(conv(b_high, b_low3), bStart);
bFinalCh1 = conv(conv(conv(b_high, b_low3), b_comb),bStart);
aFinal = conv(conv(a_high, a_low3), aStart);
aFinalCh1 = conv(conv(conv(a_high, a_low3), a_comb), aStart);

filterFinalCh1 = filter(bFinalCh1, aFinalCh1, ch1);
filterFinalCh2 = filter(bFinal, aFinal, ch2);
filterFinalCh4 = filter(bFinal, aFinal, ch4);

[finalPS1_fo, finalPS1_eegspec] = powerSpectrum(filterFinalCh1, 256);
[finalPS2_fo, finalPS2_eegspec] = powerSpectrum(filterFinalCh2, 256);
[finalPS4_fo, finalPS4_eegspec] = powerSpectrum(filterFinalCh4, 256);

close all

figure
subplot 211
plot(timeFp1, filterFinalCh1);
title('Channel 1 filtered Signal');
subplot 212
plot(finalPS1_fo,finalPS1_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Amplitude');
title('Spectrum of the EEG Channel 1, final filter');
axis tight;

figure
subplot 211
plot(timeFp1, filterFinalCh2);
title('Channel 2 filtered Signal');
subplot 212
plot(finalPS2_fo,finalPS2_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Amplitude');
title('Spectrum of the EEG Channel 2, final filter');
axis tight;

figure
subplot 211
plot(timeFp1, filterFinalCh4);
title('Channel 3 filtered Signal');
subplot 212
plot(finalPS4_fo,finalPS4_eegspec(1:ff));
xlabel('Frequency in Hz');
ylabel('Amplitude');
title('Spectrum of the EEG Channel 3, final filter');
axis tight;