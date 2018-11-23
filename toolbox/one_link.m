function [energy_in_each_point, point_passed] = one_link(transmit, recieve)
    point_passed = [];
    difference_x = abs(transmit(1) - recieve(1));
    difference_y = abs(transmit(2) - recieve(2));
    difference_z = abs(transmit(3) - recieve(3));
    [~, index] = max([difference_x difference_y difference_z]); %ѡxyz���������в�ֵ����
    switch index
        case 1
            %�������μ�һ����
            for var_x = min(transmit(1), recieve(1)) : 1 : max(transmit(1), recieve(1))
                cons = (var_x - transmit(1))/(recieve(1) - transmit(1));
                var_y = cons * (recieve(2) - transmit(2)) + transmit(2);
                var_z = cons * (recieve(3) - transmit(3)) + transmit(3);
                point_passed = [point_passed; [var_x var_y var_z]];
            end
         case 2
            for var_y = min(transmit(2), recieve(2)) : 1 : max(transmit(2), recieve(2))
                cons = (var_y - transmit(2))/(recieve(2) - transmit(2));
                var_x = cons * (recieve(1) - transmit(1)) + transmit(1);
                var_z = cons * (recieve(3) - transmit(3)) + transmit(3);
                point_passed = [point_passed; [var_x var_y var_z]];
            end
        case 3
            for var_z = min(transmit(3), recieve(3)) : 1 : max(transmit(3), recieve(3))
                cons = (var_z - transmit(3))/(recieve(3) - transmit(3));
                var_y = cons * (recieve(2) - transmit(2)) + transmit(2);
                var_x = cons * (recieve(1) - transmit(1)) + transmit(1);
                point_passed = [point_passed; [var_x var_y var_z]];
            end
    end
    point_passed = ceil(point_passed);
    distance_all_point = sum(abs(point_passed - transmit).^2,2).^(1/2);
    distance_all_point = sortrows(distance_all_point, 1);
    energy_loss = 10 * 2 * log10(distance_all_point);
    energy_loss(1, 1) = 0;
    energy_in_each_point = 100 - energy_loss;
end