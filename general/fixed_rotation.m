function R = fixed_rotation(sequence, angles)
    % Function to compute the rotation matrix from fixed angles.
    % Fixed (RPY) rotations work about fixed-axes.
    % Inputs:
    %    sequence - A string representing the order of rotations (e.g., 'xyz').
    %    angles - A 3-element vector representing the rotation angles corresponding to the sequence
    % Output:
    %   R - The resulting 3x3 rotation matrix.
    
    sequence = char(sequence);
    R = euler_rotation(flip(sequence), flip(angles));
end