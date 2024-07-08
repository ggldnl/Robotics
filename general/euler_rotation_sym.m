function R = euler_rotation_sym(sequence, angles)
    % Function to compute the rotation matrix from Euler angles
    % Inputs:
    %   sequence - A string of three characters representing the order of rotations (e.g., 'xyz')
    %   angles - A 3-element vector representing the rotation angles corresponding to the sequence
    % Output:
    %   R - The resulting 3x3 rotation matrix

    % Validate the sequence length
    if strlength(sequence) ~= 3
        error("Sequence not valid, must be of length three.")
    end
    
    % Convert the sequence to lowercase characters
    sequence = lower(char(sequence));
    
    % Validate that no two consecutive rotations are along the same axis
    if (sequence(2) == sequence(1) || sequence(2) == sequence(3))
        error("Two consecutive rotations along the same axis are not valid.")
    end
    
    % Compute the rotation matrix by multiplying the individual rotation matrices
    R = get_elementary_rotation_matrix(sequence(1), angles(1)) * ...
        get_elementary_rotation_matrix(sequence(2), angles(2)) * ...
        get_elementary_rotation_matrix(sequence(3), angles(3));
end