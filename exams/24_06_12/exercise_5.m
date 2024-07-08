
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
J = jacobian(p,q)

% Inverse kinematics

% Initial point
x_i = 0.6;
y_i = -0.4;

% Final point
x_f = 1;
y_f = 1;

q2_v_i = acos((x_i^2 + y_i^2 - A^2 - B^2) / (2*A*B)); % We will get the other configuration by taking the negated of this
q1_v_i = atan2(y_i, x_i) - atan2(B*sin(q2_v_i), A + B*cos(q2_v_i));
fprintf('Initial point (%.3f, %.3f): q1 = %.3f [rad] (%.2f°), q2 = %.3f [rad] (%.2f°)\n', x_i, y_i, q1_v_i, rad2deg(q1_v_i), q2_v_i, rad2deg(q2_v_i));

% Use this for a systematic way to compute inverse kinematics of a 2R planar robot
% [sol1_i, sol2_i] = inverse_kinematics_planar_2R(A, B, x_i, y_i);

q2_v_f = acos((x_f^2 + y_f^2 - A^2 - B^2) / (2*A*B)); % We will get the other configuration by taking the negated of this
q1_v_f = atan2(y_f, x_f) - atan2(B*sin(q2_v_f), A + B*cos(q2_v_f));
fprintf('Final point (%.3f, %.3f): q1 = %.3f [rad] (%.2f°), q2 = %.3f [rad] (%.2f°)\n', x_f, y_f, q1_v_f, rad2deg(q1_v_f), q2_v_f, rad2deg(q2_v_f));

Ji = double(subs(J, [q1 q2], [q1_v_i q2_v_i]))
Jf = double(subs(J, [q1 q2], [q1_v_f q2_v_f]))

dqi = inv(Ji) * transpose([-2 0])
dqf = inv(Jf) * transpose([2 2])
