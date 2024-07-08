
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables
syms q1 q2 q3 K L M

D = (L^2 + M^2)^(1/2)

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    -pi/2   K      0    q1;
    pi/2    0      q2   0;
    0       D      0    q3;
];

% Derive the transformation matrix
disp("Transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DHTABLE)

disp("Forward kinematics")

disp("End-effector position")
P_e = T_0_3(1:3, 4)

disp("End-effector orientation")
R_0_3 = T_0_3(1:3, 1:3)

% The matrix is an elementary rotation matrix around the z axis of q1 + q3
phi = q1 + q3
