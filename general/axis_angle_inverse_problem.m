function [theta, r1, r2] = axis_angle_inverse_problem(R, eps)
    % Given a rotation matrix, find the invariant axis of rotation.
    % Inputs:
    %   R - The 3x3 rotation matrix.
    %   eps - A small numerical tolerance for comparing norms
    %              Default value is 1e-10.
    % Output:
    %   theta - The rotation angle.
    %   r1 - one of the rotation axis.
    %   r2 - The opposite of the previous rotation axis.

    % Set default values for eps if it is not provided
    if nargin < 2
        eps = 1e-10; % Default value for eps
    end

    % Check if we are working with a rotation matrix.
    if ~check_rotation_matrix(R, eps)
        return;
    end

    sin_theta_p = 1/2 * ((R(2,1) - R(1,2))^2 + (R(1,3) - R(3,1))^2 + (R(2,3) - R(3,2))^2)^(1/2);
    sin_theta_n = -sin_theta_p;
    cos_theta = 1/2 * (R(1,1) + R(2,2) + R(3,3) - 1);
    theta = atan2(sin_theta_p, cos_theta);

    if abs(theta) < eps
        disp('theta = 0');
        error([
            'Singular case (theta=0): he rotation matrix is the identity matrix R=I' newline ...
            '  and any vector can be considered the rotation axis.'
        ]);

    elseif abs(theta - pi) < eps || abs(theta + pi) < eps
        disp('theta = pi || theta = -pi');

        % Possible sign assignments for the variables (+ or -)
        signs = [1, -1];

        % Initialize an array to store the valid assignments
        valid_assignments = [];

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

        % We should have two solutions
        if size(valid_assignments, 1) == 2
            % Assign each element to a variable
            r1 = valid_assignments(1, :);
            r2 = valid_assignments(2, :);
        else
            disp(valid_assignments);
            error('The array does not have exactly two elements. Less than 2 solutions found.');
        end

    else
        disp('theta != 0 && theta != pi && theta != -pi')
        r1 = 1/(2 * sin_theta_p) * [R(3,2) - R(2,3), R(1,3) - R(3,1), R(2,1) - R(1,2)];
        r2 = 1/(2 * sin_theta_n) * [R(3,2) - R(2,3), R(1,3) - R(3,1), R(2,1) - R(1,2)];
    end
    
end

% Example usage:
% R = [-1 0 0; 0 -1/2^(1/2) -1/2^(1/2); 0 -1/2^(1/2) 1/2^(1/2)]
% axis_angle_inverse_problem(R)
