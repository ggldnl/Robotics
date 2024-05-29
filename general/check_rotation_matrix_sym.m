function isRotationMatrix = check_rotation_matrix_sym(matrix, verbose, eps)
    % This function checks if the input matrix is a rotation matrix (symbolically)
    % Input: matrix - a numerical or symbolic matrix
    %        verbose - a boolean flag (true for detailed output, false for no output)
    %                  Default value is false.
    %        eps - a small numerical tolerance for comparing values
    %              Default value is 1e-10.
    % Output: isRotationMatrix - a logical value (true if the matrix is a rotation matrix, false otherwise)

    % Set default values for verbose and eps if they are not provided
    if nargin < 3
        eps = 1e-10; % Default value for eps
    end
    if nargin < 2
        verbose = false; % Default value for verbose
    end

    if verbose
        disp('Checking if the following is a rotation matrix:')
        disp(matrix);
    end

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Check if all columns of the matrix have unitary norm
    isNormal = check_normality_sym(matrix, verbose, eps);

    % Check if the matrix is orthogonal
    isOrthogonal = check_orthogonality_sym(matrix, verbose, eps);

    % Compute the determinant of the matrix
    determinant = compute_determinant_sym(matrix, verbose);

    % Check if the matrix is a rotation matrix
    isRotationMatrix = isNormal && isOrthogonal && abs(determinant - 1) <= eps;

    % If verbose is true, display the result
    if verbose
        if isRotationMatrix
            fprintf('The matrix is a rotation matrix.\n');
        else
            fprintf('The matrix is not a rotation matrix.\n');
        end
    end
end
