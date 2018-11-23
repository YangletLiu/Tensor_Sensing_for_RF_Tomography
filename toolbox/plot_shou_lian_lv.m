function plot_shou_lian_lv(DCTorFFt, iterationNums, error_all)
    if strcmp(DCTorFFt, 'fft')
        A_samplingRate50 = log10(error_all);
        x = 1 : iterationNums;
        creatfigure3(x, A_samplingRate50);  
    else
        A_samplingRate50 = log10(error_all);
        x = 1 : iterationNums;
        createfigure2(x, A_samplingRate50);
    end
end