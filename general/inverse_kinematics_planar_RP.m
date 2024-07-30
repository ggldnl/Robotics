% Inverse Kinematics of a RP Planar Robot
function [theta1_sol, theta2_sol] = inverse_kinematics_planar_RP(A, x, y)
    
    q2_p = (A^2 - x^2 - y^2);  % One possible solution for q2
    q2_n = -q2_p; % The other possible solution for q2

    m = A^2 + q2_p^2

    c1_p = (A*x)/m - (y*q2_p)/2
    s1_p = (A*y)/m - (x*q2_p)/2
    q1_p = atan2(s1_p, c1_p)
    
    c1_n = (A*x)/m - (y*q2_n)/2
    s1_n = (A*y)/m - (x*q2_n)/2
    q1_n = atan2(s1_n, c1_n)
    
    % Convert solutions to degrees for better understanding (optional)
    theta1_sol = [q1_p, q2_p];
    theta2_sol = [q1_n, q2_n];

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
