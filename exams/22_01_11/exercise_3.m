
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

disp("Forward kinematics")
f = [P_e(1) P_e(2) phi]

disp("Jacobian")
J = jacobian(f, [q1 q2 q3])

J_13 = subs(J, q2, 0)

disp("Null space basis for J with q2=0")
nullspace_basis = compute_null_space_basis(J_13)

disp("Range space basis for J with q2=0")
rangespace_basis = orth([J(2), J(3)])

J_v = subs(J, [L M K], [1 1 1])
r_prime_f = [-sin(q1) cos(q1) 0]
q_prime_f = simplify(J^-1 * transpose(r_prime_f))