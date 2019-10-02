clc; close all

fwm = load('finalWaveMatrix.mat');
X = fwm.finalWaveMatrix;

X = X';

%X=[ch1_gamma',ch2_gamma',ch4_gamma',ch1_alpha',ch2_alpha',ch4_alpha',ch1_delta',ch2_delta',ch4_delta',ch1_theta',ch2_theta',ch4_theta',ch1_beta',ch2_beta',ch4_beta'];

D_eu = pdist(X,'euclidean');
D_seu = pdist(X,'seuclidean');

Y_eu = cmdscale(D_eu); % nao reduz (strain)
Y_seu = cmdscale(D_seu);  % nao reduz (strain)

[Y_2_eu,stress_2_eu] = mdscale(D_eu,2,'criterion','sstress');
[Y_2_seu,stress_2_seu] = mdscale(D_seu,2,'criterion','sstress');

[Y_3_eu,stress_3_eu] = mdscale(D_eu,3,'criterion','sstress');
[Y_3_seu,stress_3_seu] = mdscale(D_seu,3,'criterion','sstress');

[Y_2_eu_2,stress_2_eu_2] = mdscale(D_eu,2,'criterion','metricstress');
[Y_2_seu_2,stress_2_seu_2] = mdscale(D_seu,2,'criterion','metricstress');

[Y_3_eu_2,stress_3_eu_2] = mdscale(D_eu,3,'criterion','metricstress');
[Y_3_seu_2,stress_3_seu_2] = mdscale(D_seu,3,'criterion','metricstress');