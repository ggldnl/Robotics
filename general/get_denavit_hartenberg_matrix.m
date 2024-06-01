function [T, A] = get_denavit_hartenberg_matrix(arrays)
    % Function to compute the Denavit-Hartenberg (DH) transformation matrix
    % Inputs:
    %   arrays - An nx4 matrix where each row represents DH parameters [alpha, a, d, theta]
    % Outputs:
    %   T - The overall transformation matrix after applying all DH transformations
    %   A - A cell array of individual transformation matrices for each set of DH parameters

    % Initialize the overall transformation matrix as the 4x4 identity matrix
    T = eye(4);
    
    % Get the number of rows in the input matrix, which represents the number of DH parameters sets
    nums = size(arrays);
    
    % Initialize a cell array to store individual transformation matrices
    A = cell(1, nums(1));
    
    % Loop through each set of DH parameters
    for i = 1:nums(1)

        % Extract the current set of DH parameters [alpha, a, d, theta]
        line = arrays(i, :);
        
        % Construct the transformation matrix for the current set of DH parameters
        R = [cos(line(4)), -cos(line(1))*sin(line(4)),  sin(line(1))*sin(line(4)), line(2)*cos(line(4));
             sin(line(4)),  cos(line(1))*cos(line(4)), -sin(line(1))*cos(line(4)), line(2)*sin(line(4));
             0,            sin(line(1)),              cos(line(1)),              line(3);
             0,            0,                         0,                         1];
        
        % Store the current transformation matrix in the cell array
        A{i} = R;
        
        % Update the overall transformation matrix by multiplying with the current matrix
        T = T * R;
    end

    % If the overall transformation matrix is symbolic, simplify it
    if isa(T, 'sym')
        T = simplify(T);
    end
end
