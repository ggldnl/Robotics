
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables for the joints
syms q1 q2 b A B C

D = (B^2 + C^2)^(1/2)

% Define DH Table
disp("Denavit Hartenberg table");
DHTABLE = [  
    0   A   0   q1;
    0   D   0   q2;
];

% Derive the transformation matrix
disp("Transformation matrix");
T_0_2 = get_denavit_hartenberg_matrix(DHTABLE)

% Define the transformation matrix between RF2 and RFe
R_2_e = [
    cos(b)  -sin(b) 0;
    sin(b)  cos(b)  0;
    0       0       1;
]
T_2_e = sym(eye(4));
T_2_e(1:3, 1:3) = R_2_e

disp("Global transformation matrix")
T_0_e = T_0_2 * T_2_e

% Forward kinematics
disp("Forward kinematics");
Px = T_0_e(1, 4)
Py = T_0_e(2, 4)
p = [Px Py]; % End-effector position on the plane

% End-effector orientation
% R_0_e = T_0_e(1:3, 1:3)
% RPY = fixed_rotation_inverse('ZYX', R_0_e)

% Inverse kinematics
disp("Inverse kinematics");

syms Px Py

c2 = (Px^2 + Px^2 - A^2 - D^2)/(2 * A * D);
s2_p = (1 - c2^2)^(1/2);
s2_n = -s2_p;

disp("First solution: ");
q2_p =  atan2(s2_p, c2)
q1_p = atan2(Py, Px) - atan2(D*s2_p, A + D*c2)

disp("Second solution: ");
q2_n = atan2(s2_n, c2)
q1_n = atan2(Py, Px) - atan2(D*s2_n, A + D*c2)

disp("Jacobian")
J = jacobian(p, [q1, q2])

disp("Jacobian in singularity q2=0")
J_1 = subs(J, [q2], [0])

% Basis for the Nullspace
disp("Null space analysis");
rank_J_1=rank(J_1)

NullSpace_J_1=null(J_1)

%{
dim_NullSpace_J_1=size(NullSpace_J_1,2);

disp("Normalizing...")
if dim_NullSpace_J_1 > 1
    % Normalize each component of the vector
    NullSpace_J_1(:,1)=NullSpace_J_1(:,1)/norm(NullSpace_J_1(:,1));
    NullSpace_J_1(:,2)=NullSpace_J_1(:,2)/norm(NullSpace_J_1(:,2));
else
    NullSpace_J_1=NullSpace_J_1/norm(NullSpace_J_1);
end

disp("Null Space basis");
NullSpace_J_1=simplify(NullSpace_J_1)
%}

disp("Dimension of the Null Space")
dim_NullSpace_J_1=size(NullSpace_J_1,2)

disp("Range space analysis");
disp("Range Space basis");
Range_J_1=orth(J_1)
% Range_J_1=simplify(orth(J_1))

disp("Dimension of the Range Space");
dim_RangeSpace_J_1=size(Range_J_1,2)

