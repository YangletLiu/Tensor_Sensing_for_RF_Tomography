function plotRSE(DCTorFFt, minSamplingRate, maxSamplingRate, error)
% load('error_fft_50sampling.mat');
x = minSamplingRate : 5 : maxSamplingRate;
axes1 = axes('Parent',figure);
p1 = plot(x,log10(error),'r-');
grid on;
p1.Marker='>';
if strcmp(DCTorFFt, 'fft')
    title('RSE of FFT');
else
    title('RSE of DCT');
end
xlabel('Sampling Rate (x 100%)','FontSize',20);ylabel('RSE in log-scale','FontSize',20);
% set(axes1,'FontSize',13,'YTickLabel',...
%     {'10^{-14}','10^{-12}','10^{-10}','10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}','10^{2}'});
set(gca,'FontSize',13);
end