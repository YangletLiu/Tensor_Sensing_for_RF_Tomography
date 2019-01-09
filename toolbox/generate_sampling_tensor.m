%% 生成采样tensor，sz表示其维度，L表示一个采样tensor里面有多少条link
function [sample_tensor, sample_tensor_real] = generate_sampling_tensor(sz, L)
    m = sz(1);
    n = sz(2);
    k = sz(3);
    sample_tensor = zeros(m, n, k);
    sample_tensor_real = zeros(m, n, k);
    for ii = 1 : 1 : L
        one_side = randi([1, 4]); %在 1-4 侧面中随机选取一个侧面，1 3为60*15，2 4为60*60
        if mod(one_side, 2) == 1  %选择标号为偶数的两个面
            %从两个面中各随机取一个点
            a = randi([1, m], 2, 1);
            b = randi([1, k], 2, 1);
            transmit = [a(1, 1), 1, b(1, 1)]; %发射节点的坐标
            recieve = [a(2, 1), n, b(2, 1)]; %接收节点的坐标
        else %选择标号为奇数的两个面
            a = randi([1, m], 2, 1);
            b = randi([1, n], 2, 1);
            transmit = [a(1, 1), b(1, 1), 1];
            recieve = [a(2, 1), b(2, 1), k];
        end
        % one_link为一对发射接收节点之间的信道链接，返回该链接经过的点和点的坐标
        [energy_in_each_point, point_passed, energy_in_each_point_real] = one_link(transmit, recieve);

        for i = 1 : 1 : size(energy_in_each_point, 1)
            sample_tensor(point_passed(i, 1), point_passed(i, 2), point_passed(i, 3)) = energy_in_each_point(i, 1);
            sample_tensor_real(point_passed(i, 1), point_passed(i, 2), point_passed(i, 3)) = energy_in_each_point_real(i, 1);
        end
    end
    sample_tensor = sample_tensor/100;
    sample_tensor_real = sample_tensor_real/100;
end
