
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables for the joints
syms q1 q2 q3 L

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    pi/2    0      q1      pi/2;
    pi/2    0      q2      pi/2;
    0       L      0       q3;
];

% Derive the transformation matrix
disp("Transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DHTABLE)

disp("Transformation matrix between word reference frame and DH reference frame 0");
T_w_0 = [
    0   0   1   0;
    1   0   0   0;
    0   1   0   0;
    0   0   0   1;
]

disp("Global transformation matrix")
T_w_3 = T_w_0 * T_0_3

% Forward kinematics
disp("Forward kinematics");
Px = T_w_3(1, 4)
Py = T_w_3(2, 4)
p = [Px Py]; % End-effector position on the plane

% End-effector orientation
% R = T_w_3(1:3, 1:3)
% RPY = fixed_rotation_inverse('ZYX', R)