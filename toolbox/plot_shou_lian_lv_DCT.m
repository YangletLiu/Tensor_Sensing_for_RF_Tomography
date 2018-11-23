load('error_dct_50sampling.mat');
A_samplingRate50 = log10(error);
x = 1 : 30;
createfigure2(x, A_samplingRate50);
