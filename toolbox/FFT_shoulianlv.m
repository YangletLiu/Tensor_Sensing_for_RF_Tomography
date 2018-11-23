load('error_all.mat');
A_samplingRate50 = log10(error_all(:,6));
x = 1 : 30;
creatfigure3(x, A_samplingRate50);