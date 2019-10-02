clc, clear all, close all
x = load('afterFilterJunto.mat');
time = load ('tempoJunto.mat');
timeFp1 = time.timeFp1;
filterFinalCh1 = x.filterFinalCh1;
filterFinalCh2 = x.filterFinalCh2;
filterFinalCh4 = x.filterFinalCh4;
clear x;

ch1_gamma=[];
ch1_beta=[];
ch1_delta=[];
ch1_alpha=[];
ch1_theta=[];
ch2_gamma=[];
ch2_beta=[];
ch2_delta=[];
ch2_alpha=[];
ch2_theta=[];
ch4_gamma=[];
ch4_beta=[];
ch4_delta=[];
ch4_alpha=[];
ch4_theta=[];

for i=1:256*5:length(timeFp1)-5*256
    
    a=wav_coef(filterFinalCh1(i:i+5*256),'db4',6);
    b=wav_coef(filterFinalCh2(i:i+5*256),'db4',6);
    c=wav_coef(filterFinalCh4(i:i+5*256),'db4',6);
    
        ch1_gamma= [ch1_gamma a(2)];
        ch1_beta=[ch1_beta a(3)];
        ch1_alpha=[ch1_alpha a(4)];
        ch1_theta=[ch1_theta a(5)];
        ch1_delta=[ch1_delta a(6)];
        
        ch2_gamma= [ch2_gamma b(2)];
        ch2_beta=[ch2_beta b(3)];
        ch2_alpha=[ch2_alpha b(4)];
        ch2_theta=[ch2_theta b(5)];
        ch2_delta=[ch2_delta b(6)];
        
        ch4_gamma= [ch4_gamma c(2)];
        ch4_beta=[ch4_beta c(3)];
        ch4_alpha=[ch4_alpha c(4)];
        ch4_theta=[ch4_theta c(5)];
        ch4_delta=[ch4_delta c(6)];

end

ab=0.1;

ch1_gamma(ch1_gamma>=ab)=ab;
ch1_beta(ch1_beta>=ab)=ab;
ch1_alpha(ch1_alpha>=ab)=ab;
ch1_theta(ch1_theta>=ab)=ab;
ch1_delta(ch1_delta>=ab)=ab;

ch2_gamma(ch2_gamma>=ab)=ab;
ch2_beta(ch2_beta>=ab)=ab;
ch2_alpha(ch2_alpha>=ab)=ab;
ch2_theta(ch2_theta>=ab)=ab;
ch2_delta(ch2_delta>=ab)=ab;

ch4_gamma(ch4_gamma>=ab)=ab;
ch4_beta(ch4_beta>=ab)=ab;
ch4_alpha(ch4_alpha>=ab)=ab;
ch4_theta(ch4_theta>=ab)=ab;
ch4_delta(ch4_delta>=ab)=ab;


%%
figure
subplot 321
plot(timeFp1(1:256*5:end-5*256),ch1_gamma)
xlabel('Time(s)');
ylabel('Amplitude');
title('Gamma 1');
axis tight;

subplot 322
plot(timeFp1(1:256*5:end-5*256),ch1_beta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Beta 1');
axis tight;

subplot 323
plot(timeFp1(1:256*5:end-5*256),ch1_alpha)
xlabel('Time(s)');
ylabel('Amplitude');
title('Alpha 1');
axis tight;

subplot 324
plot(timeFp1(1:256*5:end-5*256),ch1_theta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Theta 1');
axis tight;

subplot 325
plot(timeFp1(1:256*5:end-5*256),ch1_delta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Delta 1');
axis tight;

figure
subplot 321
plot(timeFp1(1:256*5:end-5*256),ch2_gamma)
xlabel('Time(s)');
ylabel('Amplitude');
title('Gamma 2');
axis tight;

subplot 322
plot(timeFp1(1:256*5:end-5*256),ch2_beta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Beta 2');
axis tight;

subplot 323
plot(timeFp1(1:256*5:end-5*256),ch2_alpha)
xlabel('Time(s)');
ylabel('Amplitude');
title('Alpha 2');
axis tight;

subplot 324
plot(timeFp1(1:256*5:end-5*256),ch2_theta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Theta 2');
axis tight;

subplot 325
plot(timeFp1(1:256*5:end-5*256),ch2_delta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Delta 2');
axis tight;

figure
subplot 321
plot(timeFp1(1:256*5:end-5*256),ch4_gamma)
xlabel('Time(s)');
ylabel('Amplitude');
title('Gamma 3');
axis tight;

subplot 322
plot(timeFp1(1:256*5:end-5*256),ch4_beta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Beta 3');
axis tight;

subplot 323
plot(timeFp1(1:256*5:end-5*256),ch4_alpha)
xlabel('Time(s)');
ylabel('Amplitude');
title('Alpha 3');
axis tight;

subplot 324
plot(timeFp1(1:256*5:end-5*256),ch4_theta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Theta 3');
axis tight;

subplot 325
plot(timeFp1(1:256*5:end-5*256),ch4_delta)
xlabel('Time(s)');
ylabel('Amplitude');
title('Delta 3');
axis tight;

