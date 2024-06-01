function isRotationMatrix = check_rotation_matrix(matrix, eps)
    % This function checks if the input matrix is a rotation matrix.
    % Input: matrix - a numerical or symbolic matrix.
    %        eps - a small numerical tolerance for comparing values.
    %              Default value is 1e-10.
    % Output: isRotationMatrix - a logical value (true if the matrix is a rotation matrix, false otherwise).

    % Set default values for verbose and eps if they are not provided
    if nargin < 2
        eps = 1e-10; % Default value for eps
    end

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Check if all columns of the matrix have unitary norm
    isNormal = check_normality(matrix, eps);

    % Check if the matrix is orthogonal
    isOrthogonal = check_orthogonality(matrix, eps);

    % Compute the determinant of the matrix
    determinant = compute_determinant(matrix);

    % Check if the matrix is a rotation matrix
    isRotationMatrix = isNormal && isOrthogonal && abs(determinant - 1) <= eps;

    if isRotationMatrix
        disp('The matrix is a rotation matrix.');
    else
        disp('The matrix is not a rotation matrix.');
    end
end
