function determinant = compute_determinant(matrix, verbose)
    % This function computes the determinant of the input square matrix
    % Input: matrix - a numerical square matrix
    %        verbose - a boolean flag (true for detailed output, false for no output)
    %                  Default value is false.
    % Output: determinant - the determinant of the matrix

    % Set default value for verbose if it is not provided
    if nargin < 2
        verbose = false; % Default value for verbose
    end

    % Check if the input matrix is square
    [rows, cols] = size(matrix);
    if rows ~= cols
        error('The input matrix must be square.');
    end

    % Compute the determinant
    determinant = det(matrix);

    % If verbose is true, display the result
    if verbose
        fprintf('The determinant of the matrix is %.2f\n', determinant);
    end
end
