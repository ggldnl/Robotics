
R = [
        -1          0               0; 
        0           -1/2^(1/2)      -1/2^(1/2); 
        0           -1/2^(1/2)      1/2^(1/2)
]

% Possible sign assignments for the variables (+ or -)
signs = [1, -1];

% Initialize an array to store the valid assignments
valid_assignments = [];

eps = 1e-10; % Default value for eps

a = ((R(1,1) + 1)/2)^(1/2);
b = ((R(2,2) + 1)/2)^(1/2);
c = ((R(3,3) + 1)/2)^(1/2);

% Loop through all possible combinations of signs for the three variables
for s1 = signs
    for s2 = signs
        for s3 = signs
            
            rx = s1 * a;
            ry = s2 * b;
            rz = s3 * c;
            
            if abs(rx * ry - R(1,2)/2) < eps && abs(rx * rz - R(1,3)/2) < eps && abs(ry * rz - R(2,3)/2) < eps
                
                % If the constraints are satisfied, create the assignment
                assignment = [rx, ry, rz];

                % Check if this assignment is already in valid_assignments
                if isempty(valid_assignments) || ~ismember(assignment, valid_assignments, 'rows')
                    % Add the assignment to valid_assignments
                    valid_assignments = [valid_assignments; assignment];
                end
            end
        end
    end
end

% Display the valid assignments
disp('Valid sign assignments:');
disp(valid_assignments);
