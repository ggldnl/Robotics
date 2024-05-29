function transformationMatrix = get_transformation_matrix(rotationMatrix, positionVector)
    % This function constructs a 4x4 transformation matrix from a rotation matrix and a position vector
    % Input: rotationMatrix - a 3x3 numerical or symbolic rotation matrix
    %        positionVector - a 3x1 numerical or symbolic position vector
    % Output: transformationMatrix - the corresponding 4x4 transformation matrix

    % Convert rotationMatrix and positionVector to symbolic if they are not already
    rotationMatrix = sym(rotationMatrix);
    positionVector = sym(positionVector);

    % Check if the input matrices have the correct dimensions
    [rows, cols] = size(rotationMatrix);
    if rows ~= 3 || cols ~= 3
        error('Rotation matrix must be a 3x3 matrix.');
    end

    [rows, cols] = size(positionVector);
    if rows ~= 3 || cols ~= 1
        error('Position vector must be a 3x1 vector.');
    end

    % Construct the transformation matrix
    transformationMatrix = eye(4); % Initialize as identity matrix
    transformationMatrix(1:3, 1:3) = rotationMatrix; % Insert rotation matrix
    transformationMatrix(1:3, 4) = positionVector; % Insert position vector
end
