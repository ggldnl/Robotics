
% Clear all the previously defined variables
clear all
clc

% Define symbolic variables
syms a b c

R = euler_rotation('YZY', [a b c])
