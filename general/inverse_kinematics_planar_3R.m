% Inverse Kinematics of a 3R Planar Robot
function [theta1_sol, theta2_sol, theta3_sol] = inverse_kinematics_planar_3R(L1, L2, L3, x, y, phi)
    % Compute the position of the wrist (x_w, y_w)
    x_w = x - L3 * cos(phi);
    y_w = y - L3 * sin(phi);
    
    % Calculate theta2
    cos_theta2 = (x_w^2 + y_w^2 - L1^2 - L2^2) / (2 * L1 * L2);
    
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
    theta1_1 = atan2(y_w, x_w) - atan2(k2_1, k1_1);
    theta1_2 = atan2(y_w, x_w) - atan2(k2_2, k1_2);
    
    % Calculate theta3 for both solutions
    theta3_1 = phi - theta1_1 - theta2_1;
    theta3_2 = phi - theta1_2 - theta2_2;
    
    % Convert solutions to degrees for better understanding (optional)
    theta1_sol = rad2deg([theta1_1, theta1_2]);
    theta2_sol = rad2deg([theta2_1, theta2_2]);
    theta3_sol = rad2deg([theta3_1, theta3_2]);

    % Display results
    fprintf('Solution 1: theta1 = %.2f°, theta2 = %.2f°, theta3 = %.2f°\n', theta1_sol(1), theta2_sol(1), theta3_sol(1));
    fprintf('Solution 2: theta1 = %.2f°, theta2 = %.2f°, theta3 = %.2f°\n', theta1_sol(2), theta2_sol(2), theta3_sol(2));
end

% Example usage
% L1 = 1.0; % Length of first link
% L2 = 1.0; % Length of second link
% L3 = 1.0; % Length of third link
% x = 1.5;  % Desired x position of the end-effector
% y = 1.5;  % Desired y position of the end-effector
% phi = pi/4;  % Desired orientation of the end-effector
% [theta1_sol, theta2_sol, theta3_sol] = inverse_kinematics_planar_3R(L1, L2, L3, x, y, phi);
