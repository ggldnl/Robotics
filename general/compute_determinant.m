function determinant = compute_determinant(matrix)
    % This function computes the determinant of the input square matrix.
    % Input: matrix - a numerical or symbolic square matrix.
    % Output: determinant - the determinant of the matrix.

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Check if the input matrix is square
    [rows, cols] = size(matrix);
    if rows ~= cols
        error('The input matrix must be square.');
    end

    % Compute the determinant
    determinant = det(matrix);

    % If verbose is true, display the result
    fprintf('The determinant of the matrix is %.2f.\n', determinant);

end
