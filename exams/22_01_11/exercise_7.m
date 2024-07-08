
% Clear previously defined variables
clear all
clc

% Data
joint_range = 700  % [deg]      % range of the flange rotation
nr = 30                         % reduction ratio
res_joint = 0.02                % desired resolution at the flange side

% Computation
disp("All angles are in degrees")
turns_joint = joint_range/360
turns_motor = nr * turns_joint
bits_turn = ceil(log2(turns_motor))
sectors_joint = 360 / res_joint
tracks_motor = sectors_joint / nr 
res_motor = sectors_mot
