
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

disp("End-effector frame rotation");
syms psi
% psi = -atan2(L, M)
R_3_e = [
    0   -sin(psi)   cos(psi);
    0   cos(psi)    sin(psi);
    -1  0           0;
]

disp("RF3 to RFe frame transformation matrix");

T_3_e = sym(eye(4));
T_3_e(1:3, 1:3) = R_3_e

disp("Euler minimal representation")
[sol_1 sol_2] = euler_rotation_inverse_sym('XYX', R_3_e);

disp("Solution 1:")
sol_1

disp("Solution 2:")
sol_2

disp("Numerical values of the solutions for L = M = 1")
L = 1
M = 1
psi_v = -atan2(L, M)
R_3_e_v = simplify(subs(R_3_e, psi, psi_v));
R_3_e_v

% sol_1_v = subs(sol_1, psi, psi_v)
% sol_2_v = subs(sol_2, psi, psi_v)

[sol_1_v sol_2_v] = euler_rotation_inverse_sym('xyx', R_3_e_v)

