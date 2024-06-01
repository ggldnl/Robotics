function rot = get_rotation_matrix_around_axis(theta, r)
    % Function to compute the rotation matrix around an arbitrary axis.
    % Inputs:
    %   theta - The angle of rotation (in radians).
    %   r - A 3-element vector representing the axis of rotation (must be a unit vector).
    % Output:
    %   rot - The 3x3 rotation matrix.

    % Precompute some common values to avoid redundant calculations
    c = (1 - cos(theta)); % c is the coefficient for the components of the rotation matrix
    cos_theta = cos(theta); % cosine of the angle
    sin_theta = sin(theta); % sine of the angle

    % Construct the rotation matrix using the Rodrigues' rotation formula
    rot = [
        r(1)^2*c + cos_theta,             r(1)*r(2)*c - r(3)*sin_theta,  r(1)*r(3)*c + r(2)*sin_theta;
        r(1)*r(2)*c + r(3)*sin_theta,     r(2)^2*c + cos_theta,          r(2)*r(3)*c - r(1)*sin_theta;
        r(1)*r(3)*c - r(2)*sin_theta,     r(2)*r(3)*c + r(1)*sin_theta,  r(3)^2*c + cos_theta
    ];

    % If the overall transformation matrix is symbolic, simplify it
    if isa(rot, 'sym')
        rot = simplify(rot);
    end
end