%% ���ɲ���tensor��sz��ʾ��ά�ȣ�L��ʾһ������tensor�����ж�����link
function [sample_tensor] = generate_sampling_tensor(sz, L)
    m = sz(1);
    n = sz(2);
    k = sz(3);
    sample_tensor = zeros(m, n, k);
    for ii = 1 : 1 : L
        one_side = randi([1, 4]); %�� 1-4 ���������ѡȡһ�����棬1 3Ϊ60*15��2 4Ϊ60*60
        if mod(one_side, 2) == 1  %ѡ����Ϊż����������
            %���������и����ȡһ����
            a = randi([1, m], 2, 1);
            b = randi([1, k], 2, 1);
            transmit = [a(1, 1), 1, b(1, 1)]; %����ڵ������
            recieve = [a(2, 1), n, b(2, 1)]; %���սڵ������
        else %ѡ����Ϊ������������
            a = randi([1, m], 2, 1);
            b = randi([1, n], 2, 1);
            transmit = [a(1, 1), b(1, 1), 1];
            recieve = [a(2, 1), b(2, 1), k];
        end
        % one_linkΪһ�Է�����սڵ�֮����ŵ����ӣ����ظ����Ӿ����ĵ�͵������
        [energy_in_each_point, point_passed] = one_link(transmit, recieve);

        for i = 1 : 1 : size(energy_in_each_point, 1)
            sample_tensor(point_passed(i, 1), point_passed(i, 2), point_passed(i, 3)) = energy_in_each_point(i, 1);
        end
    end
    sample_tensor = sample_tensor/100;
end