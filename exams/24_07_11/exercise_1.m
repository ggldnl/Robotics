
% Clear all the previously defined variables
clear all
clc

syms q1 q2 q3 L1 L2

disp("Denavit Hartemberg table");
DH_table = [
    [   0   0   q1  0   ];
    [   0   L1  0   q2  ];
    [   pi  L2  0   q3  ];
]

disp("Global transformation matrix");
T_0_3 = get_denavit_hartenberg_matrix(DH_table)

disp("Direct kinematics")
Px = T_0_3(1, 4)
Py = T_0_3(2, 4)
Pz = T_0_3(3, 4)

% Define L1 and L2 for our robot since we need to compute actual stuff for the trajectory planning
L1 = 9   % 9 cm
L2 = 8   % 8 cm

% Inverse kinematics

function [sol1, sol2] = inverse_kinematics(x, y, z, L1, L2)

    % First joint
    q1_v = z;

    % Third joint
    c3 = (x^2 + y^2)/(L2^2 + L1^2 + 2*L1*L2);
    s3_p = (1 - c3^2)^(1/2);
    s3_n = -s3_p;
    q3_p = atan2(s3_p, c3);
    q3_n = atan2(s3_n, c3);

    % Second joint
    A = (L2 * c3 + L1);
    % den = L2^2 + L1^2 + 2 * L1 * L2 * c3;

    B_p = L2 * s3_p;
    % c2_p = (A * x + B_p * y)/den;
    % s2_p = (-B_p * y - A * x)/den;
    c2_p = (A * x + B_p * y);
    s2_p = (-B_p * y - A * x);
    q2_p = atan2(s2_p, c2_p);

    B_n = L2 * s3_n;
    % c2_n = (A * x + B_n * y)/den;
    % s2_n = (-B_n * y + A * x)/den;
    c2_n = (A * x + B_n * y);
    s2_n = (-B_n * y + A * x);
    q2_n = atan2(s2_n, c2_n);

    sol1 = [
        q1_v, 
        q2_p, 
        q3_p
    ];
    sol2 = [
        q1_v,
        q2_n,
        q3_n
    ];
end

% Path planning
disp("Point-to-point path planning")

x_i = 0;
y_i = 0;
z_i = 0;
P_i = [
    x_i;
    y_i;
    z_i;
]

x_f = 10;
y_f = 10;
z_f = 10;
P_f = [
    x_f;
    y_f;
    z_f;
]

[sol1_i, sol2_i] = inverse_kinematics(x_i, y_i, z_i, L1, L2)
[sol1_f, sol2_f] = inverse_kinematics(x_f, y_f, z_f, L1, L2)

% Choose the pair of solutions that does not cross singularities
q_i = sol1_i % We take the first between the two initial configurations
q_f = sol2_f % We take the second between the two final configurations
d_q = q_f - q_i

function q = doubly_normalized_polynomial(q0, q1, t, coeffs)

    m = size(coeffs, 1);
    q = zeros(m, 1);
    dq = q1 - q0;

    for i = 1:m
        a3 = coeffs(i, 1);
        a2 = coeffs(i, 2);
        a1 = coeffs(i, 3);
        a0 = coeffs(i, 4);

        q(i) = q0(i) + dq(i) * (a3*t^3 + a2*t^2 + a1*t + a0);
    end
    
end

% Define the coefficients for the configuration polynomial
% Rest-to-rest case (v_i and v_f are 0)
coeffs = [
    -2, 3, 0, 0;  % Coefficients for joint 1
    -2, 3, 0, 0;  % Coefficients for joint 2
    -2, 3, 0, 0;  % Coefficients for joint 3
];

% Maximum velocities for each joint (rad/s)
v_max = [1.0, 1.0, 1.0];  % Replace with your motor's max speed in rad/s

% Compute the total time T based on maximum velocity
T = max(abs(d_q) ./ v_max)

% Time range
dt = 0.01;  % Time step
tau = 0:dt:T;

% Initialize arrays to store joint configurations
num_joints = size(coeffs, 1);
joint_configurations = zeros(num_joints, length(tau));

% Compute joint configurations for each time step
for idx = 1:length(tau)
    t_scaled = tau(idx) / T;
    joint_configurations(:, idx) = doubly_normalized_polynomial(q_i, q_f, t_scaled, coeffs);
end

% Plot joint configurations
figure;
for j = 1:num_joints
    subplot(num_joints, 1, j);
    plot(tau, joint_configurations(j, :), 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel(['Joint ' num2str(j)]);
    title(['Joint ' num2str(j) '/Time']);
    grid on;
end