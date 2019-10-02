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

wavelet = 'bior3.9';
for i=1:256*5:length(timeFp1)-5*256
    
    a=wav_coef(filterFinalCh1(i:i+5*256),wavelet,6);
    b=wav_coef(filterFinalCh2(i:i+5*256),wavelet,6);
    c=wav_coef(filterFinalCh4(i:i+5*256),wavelet,6);
    
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

ab=0.1; %0.05

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

finalWaveMatrix = [ch1_gamma; ch1_beta; ch1_alpha; ch1_theta; ch1_delta; ...
    ch2_gamma; ch2_beta; ch2_alpha; ch2_theta; ch2_delta; ...
    ch4_gamma; ch4_beta; ch4_alpha; ch4_theta; ch4_delta];

%% PCA

%S = [repmat([70],numel(zeros(1,246)),1); repmat([50],numel(zeros(1,473)),1); repmat([70],numel(zeros(1,54)),1)];
%s = S(:);

C = repmat([1 0 0],numel(zeros(1,246)),1);
C = [C; repmat([0 0 1],numel(zeros(1,473)),1)];
C = [C; repmat([1 0 0],numel(zeros(1,53)),1)];

[coeff, score] = pca(finalWaveMatrix);
coeff = coeff';
figure
scatter3(coeff(1,:),coeff(2,:),coeff(3,:),[], C);
rotate3d on
figure
scatter(coeff(1,:),coeff(2,:), [], C);

%% Clustering
coef2d = [coeff(1,:); coeff(2,:)];
coef3d = [coeff(1,:); coeff(2,:); coeff(3,:)];

coef2d = coef2d';
coef3d = coef3d';

idx = kmeans(coef2d, 2);

targets = [zeros(1,246), ones(1, 473), zeros(1, 53)];
targets = targets';



%% hierarquico

X = coef2d;

Z = linkage(X,'ward','euclidean','savememory','on');

c = cluster(Z,'maxclust',2);
%scatter(X(:,1),X(:,2),10,c)

%% Performance for PCA

targets = targets+1;

diffKmeans = minus(targets, idx);

diffabsKmeans = sumabs(diffKmeans);

scoreKmeans = diffabsKmeans/length(diffKmeans);
scoreKmeans = scoreKmeans * 100;


diffH = minus(targets, c);
diffabsH = sumabs(diffH);
scoreH = diffabsH/length(diffH);
scoreH = scoreH * 100;

scoreKmeans = 100 - scoreKmeans;
scoreH = 100 - scoreH;


if (scoreH < 50)
    scoreH
    scoreH = 100 - scoreH;
    c(find(c==1))=3;
    c(find(c==2))=1;
    c(find(c==3))=2;
end

if (scoreKmeans < 50)
    scoreKmeans
    scoreKmeans = 100 - scoreKmeans;
    idx(find(idx==1))=3;
    idx(find(idx==2))=1;
    idx(find(idx==3))=2;
end

CPkmeans = classperf(targets, idx);
CPh = classperf(targets, c);

CPkmeans.Sensitivity, CPkmeans.Specificity
disp('-------')
CPh.Sensitivity, CPh.Specificity
%% Confusion Matrix
close all
c = c - 1;
idx = idx - 1;
targets = targets - 1;

figure('Name', 'Hierarchical');
plotconfusion(targets',c')
figure('Name', 'Kmeans');
plotconfusion(targets',idx')