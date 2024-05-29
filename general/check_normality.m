function isNormal = check_normality(matrix, verbose, eps)
    % This function checks if all columns of the input matrix have a norm of 1
    % Input: matrix - a numerical matrix
    %        verbose - a boolean flag (true for detailed output, false for no output)
    %                  Default value is false.
    %        eps - a small numerical tolerance for comparing norms
    %              Default value is 1e-10.
    % Output: isNormal - a logical value (true if all columns have norm 1, false otherwise)

    % Set default values for verbose and eps if they are not provided
    if nargin < 3
        eps = 1e-10; % Default value for eps
    end
    if nargin < 2
        verbose = false; % Default value for verbose
    end

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
            if verbose
                fprintf('Column %d does not have a norm of 1. Norm = %.2f\n', col, colNorm);
            end
            return; % Exit the function early if any column does not have norm 1
        else
            if verbose
                fprintf('Column %d has a norm of 1.\n', col);
            end
        end
    end
end
