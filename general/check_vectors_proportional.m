function is_proportional = check_vectors_proportional(vector1, vector2)
    % Function to check if two vectors are proportional
    % Inputs:
    %   vector1 - The first vector.
    %   vector2 - The second vector.
    % Output:
    %   is_proportional - Boolean value indicating if vectors are proportional (true) or not (false).

    % Check if the vectors have the same length
    if length(vector1) ~= length(vector2)
        error('Vectors must have the same length.'); % Raise an error if vectors are not of the same length
    end

    % Calculate the ratio of corresponding elements
    ratios = vector1 ./ vector2;

    % Check if all ratios are the same
    is_proportional = all(ratios == ratios(1));

    % Display the result
    if is_proportional
        disp('The vectors are proportional.');
    else
        disp('The vectors are not proportional.');
    end
end
