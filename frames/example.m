
% Frame B is initially coincident with frame A. Frame B is then rotated around Yb by 30 deg, 
% then around Xb by 60 deg and then around Zb by 30 deg. Finally, the origin of B is translated
% to [Xa, Ya, Za]^T = [10, -5, 4]^T.
% 1. Find Ta_to_b.
% 2. A point in frame B is Pb = [6, -4, 1]^T. Find the coordinates of this point in A.


clear all;
clc;

% alpha is the rotation angle around x
% beta is the rotation angle around y
% gamma is the rotation angle around z 
syms alpha beta gamma;

Rx = get_elementary_rotation_matrix_sym('x', alpha);
Ry = get_elementary_rotation_matrix_sym('y', beta);
Rz = get_elementary_rotation_matrix_sym('z', gamma);

alpha = deg2rad(60);
beta = deg2rad(30);
gamma = deg2rad(30);



