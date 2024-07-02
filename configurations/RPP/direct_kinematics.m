% Direct kinematics and Inverse kinematics
% Example: RPP robot

% Clear all the previously defined variables
clear all
clc

syms q1 q2 q3

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    0      0   0    q1;
    pi/2   0   q2   pi/2;
    0      0   q3   0
];

disp("Transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DHTABLE)

xe = T_0_3(1, 4)
ye = T_0_3(2, 4)
ze = T_0_3(3, 4)
e = [xe ye ze]; 

% Inverse kinematics equations
syms x y z
eq1 = xe == x;
eq2 = ye == y;
eq3 = ze == z;

% Solve for q1, q2, q3
sol = solve([eq1, eq2, eq3], [q1, q2, q3]);

% Display solutions
q1_sol = sol.q1
q2_sol = sol.q2
q3_sol = sol.q3

% Manually check if the result is correct
% (I computed the inverse kinematics beforehand)
q3_1 = (x*2 + y^2)^(1/2)
q3_2 = -q3_1

q1_1 = atan2(y/q3_1, x/q3_1)
q1_2 = atan2(y/q3_2, x/q3_2)