function isOrthogonal = check_orthogonality(matrix, eps)
    % This function checks if the input matrix is orthogonal.
    % Input: matrix - a numerical or symbolic matrix.
    %        eps - a small numerical tolerance for comparing dot products
    %              Default value is 1e-10.
    % Output: isOrthogonal - a logical value (true if the matrix is orthogonal, false otherwise).

    % Set default values for eps if it is not provided
    if nargin < 2
        eps = 1e-10; % Default value for eps
    end

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Get the number of columns
    [~, numCols] = size(matrix);

    % Initialize the output to true
    isOrthogonal = true;

    % Check if each pair of columns is orthogonal
    for i = 1:numCols
        for j = i+1:numCols
            % Compute the dot product of column i and column j
            dotProduct = dot(matrix(:, i), matrix(:, j));
            
            % Check if the dot product is not close to zero
            if abs(dotProduct) > eps % Allowing for a small numerical tolerance
                isOrthogonal = false;
                disp('The matrix is not orthogonal.')
                return; % Exit the function early if any pair of columns is not orthogonal
            end
        end
    end

    disp('The matrix is orthogonal.')
end



function isOrthogonal = check_orthogonality_legacy(matrix)
    % This function checks if the input matrix is orthogonal.
    % Input: matrix - a numerical or symbolic matrix.
    %        eps - a small numerical tolerance for comparing dot products
    %              Default value is 1e-10.
    % Output: isOrthogonal - a logical value (true if the matrix is orthogonal, false otherwise).

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Compute the transpose of the symbolic matrix
    matrix_t = transpose(matrix)

    % Multiply the transpose by the original matrix
    product = matrix_t * matrix

    % Simplify and check if the result is 1
    isOrthogonal = isequal(simplify(product), eye(size(R)))

    % Display the result
    if isOrthogonal
        disp('The matrix is orthogonal.');
    else
        disp('The matrix is not orthogonal.');
    end

end
