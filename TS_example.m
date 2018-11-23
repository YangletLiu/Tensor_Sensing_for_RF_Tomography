function TS_example(DCTorFFt)
    %% �����˹�����
    L = randn(40, 1, 6);
    R = randn(1, 40, 6);
    X = tProd(L, R, true);
    [~, r ,~] = size(L);
    if strcmp(DCTorFFt, 'fft')
        X = fft(X);
    else
        X = dct(X);
    end
    % load('X_60_60_15_decorate.mat');
    % r = 1;
    [m, n, k] = size(X);
    sz_X = [m, n, k];
    X_s = Tensor2SmallCircM(X);
    minSamplingRate = 20;
    minSamplingRate_copy = minSamplingRate;
    maxSamplingRate = 80;
    samplingNums = (maxSamplingRate - minSamplingRate)/5 + 1;
    error = zeros(samplingNums, 1);
    errot_index = 1;
    iterationNums = 4;
    error_all = zeros(iterationNums, samplingNums);
    while(minSamplingRate <= maxSamplingRate)  
        nums = floor(m*k*n*minSamplingRate/100);
        A_all = sparse(m*k*n, nums);       %���е� A_s_v ��������һ�����һ�������
        A_all_t = sparse(m*k*n, nums);
        %% ��������˥�����ԵĲ���tensor
        for i = 1 : nums
            sampling_tensor = generate_sampling_tensor(sz_X, 20);
            A_s = Tensor2SmallCircM(sampling_tensor);
            A_s = sparse(A_s);
            A_s_t = A_s.';

            A_s_v = A_s(:);                    %  A_s_v ��ʾA_s��������
            A_s_t_v = A_s_t(:);

            A_all(:, i) = A_s_v;
            A_all_t(:, i) = A_s_t_v;
        end
        A_all = A_all.';
        A_all_t = A_all_t.';
        y = sparse(A_all*X_s(:));

        [RSE,error_single] = TS(X, X_s, A_all, A_all_t, y, iterationNums, r, minSamplingRate);    % 10Ϊ����������rΪrank
        error_all(:, errot_index) = error_single;
        error(errot_index, 1) = RSE;
        minSamplingRate = minSamplingRate + 5;
        errot_index = errot_index  + 1;
    end
    %% ���������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    plotRSE(DCTorFFt, minSamplingRate_copy, maxSamplingRate, error');
    plot_shou_lian_lv(DCTorFFt, iterationNums, error_all(:,13)');
end





