
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables for the 3 revolute joints
syms q1 q2 q3 a2 a3

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    pi/2    0       0       q1;
    0       a2      0       q2;
    0       a3      0       q3;
];

% Derive the transformation matrix
disp("Transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DHTABLE)

% Forward kinematics
disp("Forward kinematics");
Px = T_0_3(1, 4)
Py = T_0_3(2, 4)
Pz = T_0_3(3, 4)
p = [Px Py Pz]; % End-effector position

% Analytical Jacobian
disp("Analytical Jacobian");
q = [q1 q2 q3];
J0 = jacobian(p,q)

R01 = [
    cos(q1) 0 sin(q1);
    sin(q1) 0 -cos(q1);
    0 1 0;
];
R10 = simplify(R01^-1)
J1 = simplify(R10 * J0)

% Determinant
disp("Determinant");
d0 = det(J0)
% disp("Simplifying...");
% d = simplify(d)
d1 = simplify(det(J1))

% Singularities
sol = solve(d1 == 0, q);

% Access the solutions for each variable
q1_solutions = sol.q1;
q2_solutions = sol.q2;
q3_solutions = sol.q3;

% Display the solutions
disp('Solutions for q1:');
disp(q1_solutions);

disp('Solutions for q2:');
disp(q2_solutions);

disp('Solutions for q3:');
disp(q3_solutions);

% In a singular configuration find a basis for the subspaces N(J_s) and R(J_s)
disp('Singularity q=(q1, q2, 0)');
conf = [q1 q2 0];
Js = subs(J0, q, conf)

% Basis for the Nullspace
disp('Null space basis:');
null_basis = null(Js)

