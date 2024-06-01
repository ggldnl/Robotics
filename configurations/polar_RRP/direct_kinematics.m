% Direct kinematics
% Example: polar RRP robot
% by A. De Luca, first 25 Nov 2011 

clear all
clc

%% Define symbolic variables
syms alpha d a theta

% length l
d = 0.5;

%% number of joints of SCARA

N=4;

%% Insert DH table of parameters of SCARA

DHTABLE = [  0   sym('a1') sym('d1') sym('q1');
             0   sym('a2')    0      sym('q2');
             0     0       sym('q3')    0;
             pi    0       sym('d4') sym('q4')];

         
%% Build the general Denavit-Hartenberg trasformation matrix

TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
        sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
          0             sin(alpha)             cos(alpha)            d;
          0               0                      0                   1];

%% Build transformation matrices for each link
% First, we create an empty cell array

A = cell(1,N);

% For every row in 'DHTABLE' we substitute the right value inside
% the general DH matrix

for i = 1:N
    alpha = DHTABLE(i,1);
    a = DHTABLE(i,2);
    d = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = subs(TDH);
end

%% Direct kinematics

disp('Direct kinematics of SCARA robot in symbolic form:')

disp(['Number of joints N=',num2str(N)])

% Note: 'simplify' may need some time

T = eye(4);

for i=1:N 
    T = T*A{i};
    T = simplify(T);
end

% output TN matrix

T0N = T

% output ON position

p = T(1:3,4)

% output xN axis

n=T(1:3,1)

% output yN axis

s=T(1:3,2)

% output zN axis

a=T(1:3,3)

%% end

disp('Closed form solution:')
% px = q3*cos(q2)*cos(q1)
% py = q3*cos(q2)*sin(q1)
% pz = d + q3*sin(q2)
