function plotGraphs(coef, gModel, bins, xlow, xhigh, nGaussian)
% plotGraphs(coef, gModel, bins, xlow, xhigh, nGaussian)
%
% plotGraphs plots 3 subplots
% the first one containing the histogram
% the second one the obtained gaussian functions
% the third one each of the gaussians by itself
%
% coef are the wavelets coefs from the original image
% gModel the gaussian model fitted to the coefs
% bins is the number of bins for the histogram
% xlow and xhigh are the arguments for xlim
% nGausssian is the number of gaussians obtained in gModel
[countImg, edgeImg] = histcounts(coef, bins);
edgeImg = edgeImg(:,2:end);
edgeImg = edgeImg';

subplot 311
stem(edgeImg, countImg, 'MarkerSize', 1 );
xlim([xlow xhigh]);

subplot 312
plot(edgeImg, pdf(gModel,edgeImg));
xlim([xlow xhigh]);

subplot 313
for j=1:nGaussian
    line(edgeImg,gModel.PComponents(j)*normpdf(edgeImg,gModel.mu(j),sqrt(gModel.Sigma(j))),'color','r');
end
xlim([50 800]);

end