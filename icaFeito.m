clc, close all, clear all

matrix = load('afterIcaJunto.mat');
matrix = matrix.matrizPosIca;
time = load('tempoJunto.mat');
time = time.timeFp1;
x = load('bis.mat');
bis = x.bis;
timebis = x.timeBis;

newMatrix = [matrix(1,:);matrix(2,:);matrix(3,:)];


%%
figure('Name', 'ICA 1')
plot(time(1:5120), matrix(1,1:5120));
ylim([-10,10]);
title('ICA 1');
figure('Name', 'ICA 2')
plot(time(1:5120), matrix(2,1:5120));
ylim([-10,10]);
title('ICA 2');
figure('Name', 'ICA 3')
plot(time(1:5120), matrix(3,1:5120));
ylim([-10,10]);
title('ICA 3');
figure('Name', 'ICA 4')
plot(time(1:5120), matrix(4,1:5120));
ylim([-10,10]);
title('ICA 4');
figure('Name', 'ICA 5')
plot(time(1:5120), matrix(5,1:5120));
ylim([-10,10]);
title('ICA 5');
figure('Name', 'ICA 6')
plot(time(1:5120), matrix(6,1:5120));
ylim([-10,10]);
title('ICA 6');
figure('Name', 'ICA 7')
plot(time(1:5120), matrix(7,1:5120));
ylim([-10,10]);
title('ICA 7');
figure
plot(1:size(timebis,2),bis(1,:));