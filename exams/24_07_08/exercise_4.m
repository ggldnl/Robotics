% Clear previously defined variables
clear all
clc

% Define symbolic variables
syms x y

q1 = atan2(y, x)
q2 = (x^2 + y^2)^(1/2)

x_i = 0.6
y_i = -0.3

q1_i = atan2(y_i, x_i)
q2_i = (x_i^2 + y_i^2)^(1/2)
q_i = [q1_i q2_i]

x_f = -0.3
y_f = 0.6

q1_f = atan2(y_f, x_f)
q2_f = (x_f^2 + y_f^2)^(1/2)
q_f = [q1_f q2_f]

d = q_f - q_i