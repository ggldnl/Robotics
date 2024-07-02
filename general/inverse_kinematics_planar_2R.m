% Inverse Kinematics of a 2R Planar Robot
function [theta1_sol, theta2_sol] = inverse_kinematics_planar_2R(L1, L2, x, y)
    % Calculate theta2
    cos_theta2 = (x^2 + y^2 - L1^2 - L2^2) / (2 * L1 * L2);
    
    % Check if the position is reachable
    if abs(cos_theta2) > 1
        error('The given position is not reachable.');
    end
    
    theta2_1 = acos(cos_theta2);  % One possible solution for theta2
    theta2_2 = -acos(cos_theta2); % The other possible solution for theta2

    % Calculate k1 and k2 for both solutions
    k1_1 = L1 + L2 * cos(theta2_1);
    k2_1 = L2 * sin(theta2_1);
    
    k1_2 = L1 + L2 * cos(theta2_2);
    k2_2 = L2 * sin(theta2_2);

    % Calculate theta1 for both solutions
    theta1_1 = atan2(y, x) - atan2(k2_1, k1_1);
    theta1_2 = atan2(y, x) - atan2(k2_2, k1_2);
    
    % Convert solutions to degrees for better understanding (optional)
    theta1_sol = [theta1_1, theta1_2];
    theta2_sol = [theta2_1, theta2_2];

    % Display results
    fprintf('Solution 1: q1 = %.3f [rad] (%.2f°), q2 = %.3f [rad] (%.2f°)\n', theta1_sol(1), rad2deg(theta1_sol(1)), theta2_sol(1), rad2deg(theta2_sol(1)));
    fprintf('Solution 2: q1 = %.3f [rad] (%.2f°), q2 = %.3f [rad] (%.2f°)\n', theta1_sol(2), rad2deg(theta1_sol(2)), theta2_sol(2), rad2deg(theta2_sol(2)));

end

% Example usage
% L1 = 1.0; % Length of first link
% L2 = 1.0; % Length of second link
% x = 1.5;  % Desired x position of the end-effector
% y = 1.5;  % Desired y position of the end-effector
% [theta1_sol, theta2_sol] = inverse_kinematics_planar_2R(L1, L2, x, y);
