
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables for the 2 revolute joints
syms q1 q2

A = 1;
B = 1;

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    0       A      0       q1;
    0       B      0       q2;
];

% Derive the transformation matrix
disp("Transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DHTABLE)

% Forward kinematics
disp("Forward kinematics");
Px = T_0_3(1, 4)
Py = T_0_3(2, 4)
p = [Px Py]; % End-effector position

% Analytical Jacobian
disp("Analytical Jacobian");
q = [q1 q2];
J0 = jacobian(p,q)

disp("Determinant");
d0 = det(J0)

% Singularities
sol = solve(d0 == 0, q);

% Access the solutions for each variable
q1_solutions = sol.q1;
q2_solutions = sol.q2;

% Display the solutions
disp('Solutions for q1:');
disp(q1_solutions);

disp('Solutions for q2:');
disp(q2_solutions);

% Inverse kinematics
x = 0.6;
y = -0.4;

fprintf("Configuration to (%.3f, %.3f)",x, y);
q2_v = acos((x^2 + y^2 - A^2 - B^2) / (2*A*B)) % We will get the other configuration by taking the negated of this
s2 = sin(q2_v);
c2 = cos(q2_v);
q1_v = atan2(y, x) - atan2(B*s2, A + B*c2)

q1_v_deg = rad2deg(q1_v)
q2_v_deg = rad2deg(q2_v)

%{
% Plot the 2R planar robot
figure;
hold on;
axis equal;
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('2R Planar Robot');

% Calculate the positions of each joint
P0 = [0, 0]; % Base of the robot
P1 = double(subs([A*cos(q1), A*sin(q1)], q1, q1_v));
P2 = double(subs([Px, Py], {q1, q2}, {q1_v, q2_v}));

% Plot the links
plot([P0(1), P1(1)], [P0(2), P1(2)], 'b-o', 'LineWidth', 2, 'MarkerSize', 10);
plot([P1(1), P2(1)], [P1(2), P2(2)], 'r-o', 'LineWidth', 2, 'MarkerSize', 10);

% Plot the joints
% plot(P0(1), P0(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
% plot(P1(1), P1(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
% plot(P2(1), P2(2), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

% Annotate the joint values
text(P0(1), P0(2), sprintf('(0, 0)'), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(P1(1), P1(2), sprintf('q1=%.2f rad\n(%.2f, %.2f)', q1_val, P1(1), P1(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(P2(1), P2(2), sprintf('q2=%.2f rad\n(%.2f, %.2f)', q2_val, P2(1), P2(2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

legend('Link 1', 'Link 2', 'Joint 1', 'Joint 2', 'End-Effector');
hold off;
%}
