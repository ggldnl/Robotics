function [sol_1, sol_2] = fixed_rotation_inverse_sym(sequence, R)
    % [sol_1, sol_2] = fixed_rotation_inverse_sym(sequence, R) takes as inputs:
    %   -sequence: a string which specifies how the RPY-rotation has been computed, e.g. "xyx"
    %   -R: the rotation to be decomposed, should be a 3x3 matrix
    % and outputs:
    %   -sol_1: vector of the three angles (phi, theta, psi) for the first solution
    %   -sol_2: vector of the three angles (phi, theta, psi) for the second solution
    %
    % RPY rotations work about fixed-axes
    
    sequence = char(sequence);
    [sol_1, sol_2] = euler_rotation_inverse_sym(flip(sequence), R);

end