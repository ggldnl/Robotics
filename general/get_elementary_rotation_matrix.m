function R = get_elementary_rotation_matrix(axis, s)
    % This function returns a symbolic elementary rotation matrix for a given axis and angle.
    % Input: axis - a character indicating the axis of rotation ('x', 'y', or 'z').
    %        s - the angle of rotation (symbolic).
    % Output: R - the 3x3 symbolic rotation matrix corresponding to the specified axis and angle.

    % Convert the angle to a symbolic variable if it is not already
    s = sym(s);

    % Determine the rotation matrix based on the specified axis
    switch axis
        case {"x", "X"}
            % Rotation matrix for rotation around the x-axis
            R = [1,       0,        0;
                 0,    cos(s),   -sin(s);
                 0,    sin(s),    cos(s)];
        case {"y", "Y"}
            % Rotation matrix for rotation around the y-axis
            R = [cos(s),     0,   sin(s);
                 0,          1,     0;
                 -sin(s),    0,   cos(s)];
        case {"z", "Z"}
            % Rotation matrix for rotation around the z-axis
            R = [cos(s),  -sin(s),    0;
                 sin(s),   cos(s),    0;
                 0,        0,       1];
        otherwise
            % Display an error message if the axis is not recognized
            error("First parameter should be either 'x', 'y', 'z' or any of those capitalized");
    end
end
