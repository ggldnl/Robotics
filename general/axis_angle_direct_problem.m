function rot = axis_angle_direct_problem(theta, r)
    % Given a unit vector r and an angle theta, compute the rotation matrix 
    % of angle theta round unit vector r.
    % Inputs:
    %   theta - The angle of rotation (in radians).
    %   r - A 3-element vector representing the axis of rotation (must be a unit vector).
    % Output:
    %   rot - The 3x3 rotation matrix.

    cO = cos(theta);
    sO = sin(theta);

    rot = [
        r(1)^2 * (1-cO) + cO, r(1) * r(2) * (1-cO) - r(3) * sO, r(1) * r(3) * (1-cO) + r(2) * sO;
        r(1) * r(2) * (1-cO) + r(3) * sO, r(2)^2 * (1-cO) + cO, r(2) * r(3) * (1-cO) - r(1) * sO;
        r(1) * r(3) * (1-cO) - r(2) * sO, r(2) * r(3) * (1-cO) + r(1) * sO, r(3) * r(3) * (1-cO) + cO;
    ];

    % If the overall transformation matrix is symbolic, simplify it
    if isa(rot, 'sym')
        rot = simplify(rot);
    end
end