%% Load Data

clc, clear all, close all


coeff = load('pcaCoeffnosquare.mat');

coeff = coeff.coeff;

coef2d = [coeff(1,:); coeff(2,:)];
coef3d = [coeff(1,:); coeff(2,:); coeff(3,:)];
coef2d = coef2d';
coef3d = coef3d';

%% Clustering

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
c = c - 1;
idx = idx - 1;
targets = targets - 1;

figure('Name', 'Hierarchical');
plotconfusion(targets',c')
figure('Name', 'Kmeans');
plotconfusion(targets',idx')