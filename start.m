clc, clear all, close all
%10/20 positioning
%zeus tem info do patiente, o BIS, com imensos dados de segundo a segundo
%frontais sao os usados

x = load('zeus_data_pat10_v2.mat');
x = x.data;
bis = x.BIS;
timeBis = x.Time;

tf = trc_file('EEG_7.TRC');
tf.get_electrode_info(); %a file elec cell para a estrutura
tf.get_notes();
notes = tf.a_note_struct;

NaNindex = find(isnan(bis));
NaNindex = [NaNindex; NaNindex*60*256; [NaNindex*60*256]/256];

%remove = [1:5, 15, 21:46, 56, 66, 74:76, 86, 96, 98, 106,107];
%Fp1 Fp2 F7 F3 Fz F4 F8
%bis sqi acima de 80

a = tf.a_n_data_secs;
[dataFp1,timeFp1] = tf.def_data_access(a, a, {'Fp1'},0);
[dataFp2,timeFp2] = tf.def_data_access(a, a, {'Fp2'},0);
[dataF7,timeF7] = tf.def_data_access(a, a, {'F7'},0);
[dataF3,timeF3] = tf.def_data_access(a, a, {'F3'},0);
[dataFz,timeFz] = tf.def_data_access(a, a, {'Fz'},0);
[dataF4,timeF4] = tf.def_data_access(a, a, {'F4'},0);
[dataF8,timeF8] = tf.def_data_access(a, a, {'F8'},0);

dataFp1Og = dataFp1;

% dataFp1(1:76800)=NaN; %1 a 5
dataFp1(230400:245759+23040)=NaN; %15, pode se preencher
dataFp1(322560-15360:706560+15360)=NaN; %21 a 46
dataFp1(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataFp1(1136640-15360:1167360)=NaN;%74 a 76
dataFp1(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataFp1(1628160-23040:1637036)=NaN;%106 a 107
dataFp1(1392640:1401600)=NaN;%extra
dataFp1(1434880:1443840)=NaN;%extra
dataFp1(dataFp1>=200)=0;
dataFp1(dataFp1<=-200)=0;
% dataFp1(isnan(dataFp1))=0;
timeFp1(find(isnan(dataFp1)))=[];
dataFp1(find(isnan(dataFp1)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataFp2(230400:245759+23040)=NaN; %15, pode se preencher
dataFp2(322560-15360:706560+15360)=NaN; %21 a 46
dataFp2(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataFp2(1136640-15360:1167360)=NaN;%74 a 76
dataFp2(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataFp2(1628160-23040:1637036)=NaN;%106 a 107
dataFp2(1392640:1401600)=NaN;%extra
dataFp2(1434880:1443840)=NaN;%extra
dataFp2(dataFp2>=200)=0;
dataFp2(dataFp2<=-200)=0;
% dataFp2(isnan(dataFp2))=0;
dataFp2(find(isnan(dataFp2)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataFz(230400:245759+23040)=NaN; %15, pode se preencher
dataFz(322560-15360:706560+15360)=NaN; %21 a 46
dataFz(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataFz(1136640-15360:1167360)=NaN;%74 a 76
dataFz(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataFz(1628160-23040:1637036)=NaN;%106 a 107
dataFz(1392640:1401600)=NaN;%extra
dataFz(1434880:1443840)=NaN;%extra
dataFz(dataFz>=200)=0;
dataFz(dataFz<=-200)=0;
% dataFz(isnan(dataFz))=0;
dataFz(find(isnan(dataFz)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataF3(230400:245759+23040)=NaN; %15, pode se preencher
dataF3(322560-15360:706560+15360)=NaN; %21 a 46
dataF3(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataF3(1136640-15360:1167360)=NaN;%74 a 76
dataF3(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataF3(1628160-23040:1637036)=NaN;%106 a 107
dataF3(1392640:1401600)=NaN;%extra
dataF3(1434880:1443840)=NaN;%extra
dataF3(dataF3>=200)=0;
dataF3(dataF3<=-200)=0;
% dataF3(isnan(dataF3))=0;
dataF3(find(isnan(dataF3)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataF4(230400:245759+23040)=NaN; %15, pode se preencher
dataF4(322560-15360:706560+15360)=NaN; %21 a 46
dataF4(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataF4(1136640-15360:1167360)=NaN;%74 a 76
dataF4(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataF4(1628160-23040:1637036)=NaN;%106 a 107
dataF4(1392640:1401600)=NaN;%extra
dataF4(1434880:1443840)=NaN;%extra
dataF4(dataF4>=200)=0;
dataF4(dataF4<=-200)=0;
% dataF4(isnan(dataF4))=0;
dataF4(find(isnan(dataF4)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataF7(230400:245759+23040)=NaN; %15, pode se preencher
dataF7(322560-15360:706560+15360)=NaN; %21 a 46
dataF7(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataF7(1136640-15360:1167360)=NaN;%74 a 76
dataF7(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataF7(1628160-23040:1637036)=NaN;%106 a 107
dataF7(1392640:1401600)=NaN;%extra
dataF7(1434880:1443840)=NaN;%extra
dataF7(dataF7>=200)=0;
dataF7(dataF7<=-200)=0;
% dataF7(isnan(dataF7))=0;
dataF7(find(isnan(dataF7)))=[];


% dataFp1(1:76800)=NaN; %1 a 5
dataF8(230400:245759+23040)=NaN; %15, pode se preencher
dataF8(322560-15360:706560+15360)=NaN; %21 a 46
dataF8(860160-15360:875159+15360)=NaN;%56
% dataFp1(1013760-15360:1029119+15360)=0;%66
dataF8(1136640-15360:1167360)=NaN;%74 a 76
dataF8(1320960-15360:1336319+23040)=NaN;%86
% dataFp1(1474560-15360:1505280+15360)=0;%96 a 98
dataF8(1628160-23040:1637036)=NaN;%106 a 107
dataF8(1392640:1401600)=NaN;%extra
dataF8(1434880:1443840)=NaN;%extra
dataF8(dataF8>=200)=0;
dataF8(dataF8<=-200)=0;
% dataF8(isnan(dataF8))=0;
dataF8(find(isnan(dataF8)))=[];

%%

figure
subplot 811
plot(timeFp1,dataFp1);
title('EEG Canal FP1')
xlabel('s');
subplot 812
plot(timeFp1,dataFp2);
title('EEG Canal FP1')
xlabel('s');
subplot 813
plot(timeFp1,dataF3);
title('EEG Canal FP1')
xlabel('s');
subplot 814
plot(timeFp1,dataF4);
title('EEG Canal FP1')
xlabel('s');
subplot 815
plot(timeFp1,dataF7);
title('EEG Canal FP1')
xlabel('s');
subplot 816
plot(timeFp1,dataF8);
title('EEG Canal FP1')
xlabel('s');
subplot 817
plot(timeFp1,dataFz);
title('EEG Canal FP1')
xlabel('s');
subplot 818
plot(0:length(timeBis)-1, bis);
xlabel('min')
title('BIS')

%% ICA

matrizIca=[dataFp1;dataFp2;dataF3;dataF4;dataF7;dataF8;dataFz];
matrizPosIca=fastica(matrizIca);


figure('Name','Channel ICA');
subplot 811
plot(timeFp1,matrizPosIca(1,:));
ylim([-20 20])
subplot 812
plot(timeFp1,matrizPosIca(2,:));
subplot 813
plot(timeFp1,matrizPosIca(3,:));
subplot 814
plot(timeFp1,matrizPosIca(4,:));
subplot 815
plot(timeFp1,matrizPosIca(5,:));
subplot 816
plot(timeFp1,matrizPosIca(6,:));
subplot 817
plot(timeFp1,matrizPosIca(7,:));
subplot 818
plot(0:length(timeBis)-1, bis);