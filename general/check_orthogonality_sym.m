function isOrthogonal = check_orthogonality_sym(matrix, verbose, eps)
    % This function checks if the input matrix is orthogonal (symbolically)
    % Input: matrix - a numerical or symbolic matrix
    %        verbose - a boolean flag (true for detailed output, false for no output)
    %                  Default value is false.
    %        eps - a small numerical tolerance for comparing dot products
    %              Default value is 1e-10.
    % Output: isOrthogonal - a logical value (true if the matrix is orthogonal, false otherwise)

    % Set default values for verbose and eps if they are not provided
    if nargin < 3
        eps = 1e-10; % Default value for eps
    end
    if nargin < 2
        verbose = false; % Default value for verbose
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
                if verbose
                    fprintf('Columns %d and %d are not orthogonal. Dot product = %.2f\n', i, j, dotProduct);
                end
                return; % Exit the function early if any pair of columns is not orthogonal
            else
                if verbose
                    fprintf('Columns %d and %d are orthogonal.\n', i, j);
                end
            end
        end
    end
end