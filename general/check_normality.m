function isNormal = check_normality(matrix, eps)
    % This function checks if all columns of the input matrix have a norm of 1.
    % Input: matrix - a numerical or symbolic matrix.
    %        eps - a small numerical tolerance for comparing norms
    %              Default value is 1e-10.
    % Output: isNormal - a logical value (true if all columns have norm 1, false otherwise).

    % Set default values for eps if it is not provided
    if nargin < 2
        eps = 1e-10; % Default value for eps
    end

    % Convert matrix to symbolic if it is not already
    matrix = sym(matrix);

    % Get the number of columns
    [~, numCols] = size(matrix);

    % Initialize the output to true
    isNormal = true;

    for col = 1:numCols
        % Compute the norm of the current column
        colNorm = norm(matrix(:, col));

        % Check if the norm is not equal to 1
        if abs(colNorm - 1) > eps % Allowing for a small numerical tolerance
            isNormal = false;
            disp('The matrix is not normal.')
            return; % Exit the function early if any column does not have norm 1
        end
    end

    % Display the result
    disp('The matrix is normal.');

end
