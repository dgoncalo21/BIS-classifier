%% MDSing
clc, clear all, close all

fwm = load('finalWaveMatrix.mat');
X = fwm.finalWaveMatrix;

X = X';

D_eu = pdist(X,'euclidean');
D_cb = pdist(X,'cityblock');
D_chev = pdist(X,'chebychev');

opts = statset('Display', 'iter', 'MaxIter', 1000);

Y_eu = cmdscale(D_eu); % nao reduz (strain)
Y_cb = cmdscale(D_cb);  % nao reduz (strain)
Y_chev = cmdscale(D_chev);

[Y_2_eu,stress_2_eu] = mdscale(D_eu,2,'criterion','sstress', 'Options', opts);
[Y_2_seu,stress_2_seu] = mdscale(D_cb,2,'criterion','sstress', 'Options', opts);
[Y_2_chev,stress_2_chev] = mdscale(D_chev,2,'criterion','sstress', 'Options', opts);

[Y_2_eu_2,stress_2_eu_2] = mdscale(D_eu,2,'criterion','metricstress', 'Options', opts);
[Y_2_seu_2,stress_2_seu_2] = mdscale(D_cb,2,'criterion','metricstress', 'Options', opts);
[Y_2_chev_2,stress_2_chev_2] = mdscale(D_chev,2,'criterion','metricstress', 'Options', opts);

[Y_3_eu,stress_3_eu] = mdscale(D_eu,3,'criterion','sstress', 'Options', opts);
[Y_3_seu,stress_3_seu] = mdscale(D_cb,3,'criterion','sstress', 'Options', opts);
[Y_3_chev,stress_3_chev] = mdscale(D_chev,3,'criterion','sstress', 'Options', opts);

[Y_3_eu_2,stress_3_eu_2] = mdscale(D_eu,3,'criterion','metricstress', 'Options', opts);
[Y_3_seu_2,stress_3_seu_2] = mdscale(D_cb,3,'criterion','metricstress', 'Options', opts);
[Y_3_chev_2,stress_3_chev_2] = mdscale(D_chev,3,'criterion','metricstress', 'Options', opts);


%%

C = repmat([1 0 0],numel(zeros(1,246)),1);
C = [C; repmat([0 0 1],numel(zeros(1,473)),1)];
C = [C; repmat([1 0 0],numel(zeros(1,53)),1)];

Y_2_eu = Y_2_eu';
Y_3_eu = Y_3_eu';

figure
scatter3(Y_3_eu(1,:),Y_3_eu(2,:),Y_3_eu(3,:),[], C);
rotate3d on
figure
scatter(Y_2_eu(1,:),Y_2_eu(2,:), [], C);