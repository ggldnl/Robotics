
% Clear all the previously defined variables
clear all
clc

R = [
    2^(1/2)/2   0   2^(1/2)/2;
    2^(1/2)/2   0   -2^(1/2)/2;
    0           1   0;  
]

% [sol_1 sol_2] = fixed_rotation_inverse('yzx', R)

% Define the rotation matrix representing rotation around YZX axis
%{
R = [
    cos(beta)*cos(gamma), sin(alpha)*sin(beta)*cos(gamma) - cos(alpha)*sin(gamma), cos(alpha)*sin(beta)*cos(gamma) + sin(alpha)*sin(gamma);
    cos(beta)*sin(gamma), sin(alpha)*sin(beta)*sin(gamma) + cos(alpha)*cos(gamma), cos(alpha)*sin(beta)*sin(gamma) - sin(alpha)*cos(gamma);
    -sin(beta),           sin(alpha)*cos(beta),                                  cos(alpha)*cos(beta)
];
%}

% Compute angles alpha, beta, gamma from the rotation matrix
% Handling singular cases
R(3, 1)
if abs(R(3,1)) ~= 1
    disp("Singular case")
    beta = -asin(R(3,1));
    alpha = atan2(R(3,2)/cos(beta), R(3,3)/cos(beta));
    gamma = atan2(R(2,1)/cos(beta), R(1,1)/cos(beta));
else
    gamma = 0; % Arbitrary value, can be adjusted
    if R(3,1) == -1
        beta = pi/2;
        alpha = gamma + atan2(R(1,2), R(1,3));
    else
        beta = -pi/2;
        alpha = -gamma + atan2(-R(1,2), -R(1,3));
    end
end

% Ensure alpha, beta, gamma are within the range [-pi, pi]
alpha = mod(alpha, 2*pi);
if alpha > pi
    disp("alpha = alpha - 2*pi")
    alpha = alpha - 2*pi;
end
beta = mod(beta, 2*pi);
if beta > pi
    disp("beta = beta - 2*pi")
    beta = beta - 2*pi;
end
gamma = mod(gamma, 2*pi);
if gamma > pi
    disp("gamma = gamma - 2*pi")
    gamma = gamma - 2*pi;
end

phi = [
    alpha
    beta
    gamma
]

% Reconstruct rotation matrix from angles alpha, beta, gamma
R_reconstructed = [cos(beta)*cos(gamma), sin(alpha)*sin(beta)*cos(gamma) - cos(alpha)*sin(gamma), cos(alpha)*sin(beta)*cos(gamma) + sin(alpha)*sin(gamma);
                   cos(beta)*sin(gamma), sin(alpha)*sin(beta)*sin(gamma) + cos(alpha)*cos(gamma), cos(alpha)*sin(beta)*sin(gamma) - sin(alpha)*cos(gamma);
                  -sin(beta),           sin(alpha)*cos(beta),                                  cos(alpha)*cos(beta)];

% Display original and reconstructed rotation matrices
disp('Original Rotation Matrix:');
disp(R);
disp('Reconstructed Rotation Matrix:');
disp(R_reconstructed);

T = [
    1   0               -sin(beta);
    0   -sin(gamma)     cos(beta)*cos(gamma);
    0   cos(gamma)      cos(beta)*sin(gamma);
]

w = [
    1;
    1;
    2;
]

phi_dot = T^-1 * w