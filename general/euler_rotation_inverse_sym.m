function [sol_1, sol_2] = euler_rotation_inverse_sym(sequence, R)
    % [sol_1, sol_2] = euler_rotation_inverse_sym(sequence, R) takes as inputs:
    %   -sequence: a string which specifies how the euler-rotation has been computed, e.g. "xyx"
    %   -R: the rotation to be decomposed, should be a 3x3 matrix
    % and outputs:
    %   -sol_1: vector of the three angles (phi, theta, psi) for the first solution
    %   -sol_2: vector of the three angles (phi, theta, psi) for the second solution
    %
    % Euler rotations work about moving-axes
    
    if strlength(sequence) ~= 3
        error("Invalid sequence, must be of length three.")
    end
    
    if (sequence(2) == sequence(1) || sequence(2) == sequence(3))
        error("Two consecutive rotation along the same axis are not valid.")
    end
    
    switch lower(sequence)
        case "xyx"
            theta_pos = atan2(sqrt(R(1, 2)^2 + R(1, 3)^2), R(1, 1));
            theta_neg = atan2(-sqrt(R(1, 2)^2 + R(1, 3)^2), R(1, 1));
            
            psi_pos = atan2(R(1, 2)/sin(theta_pos), R(1, 3)/sin(theta_pos));
            phi_pos = atan2(R(2, 1)/sin(theta_pos), -R(3, 1)/sin(theta_pos));
            
            psi_neg = atan2(R(1, 2)/sin(theta_neg), R(1, 3)/sin(theta_neg));
            phi_neg = atan2(R(2, 1)/sin(theta_neg), -R(3, 1)/sin(theta_neg));
            
        case "xyz"
            theta_pos = atan2(R(1, 3), sqrt(R(1, 1)^2 + R(1, 2)^2));
            theta_neg = atan2(R(1, 3), -sqrt(R(1, 1)^2 + R(1, 2)^2));
            
            psi_pos = atan2(-R(1, 2)/cos(theta_pos), R(1, 1)/cos(theta_pos));
            phi_pos = atan2(-R(2, 3)/cos(theta_pos), R(3, 3)/cos(theta_pos));
            
            psi_neg = atan2(-R(1, 2)/cos(theta_neg), R(1, 1)/cos(theta_neg));
            phi_neg = atan2(-R(2, 3)/cos(theta_neg), R(3, 3)/cos(theta_neg));
            
        case "xzx"
            theta_pos = atan2(sqrt(R(1, 2)^2 + R(1, 3)^2), R(1, 1));
            theta_neg = atan2(-sqrt(R(1, 2)^2 + R(1, 3)^2), R(1, 1));
            
            psi_pos = atan2(R(1, 3)/sin(theta_pos), -R(1, 2)/sin(theta_pos));
            phi_pos = atan2(R(3, 1)/sin(theta_pos), R(2, 1)/sin(theta_pos));
            
            psi_neg = atan2(R(1, 3)/sin(theta_neg), -R(1, 2)/sin(theta_neg));
            phi_neg = atan2(R(3, 1)/sin(theta_neg), R(2, 1)/sin(theta_neg));
            
        case "xzy"
            theta_pos = atan2(-R(1, 2), sqrt(R(1, 1)^2 + R(1, 3)^2));
            theta_neg = atan2(-R(1, 1), -sqrt(R(1, 3)^2 + R(2, 1)^2));
            
            psi_pos = atan2(R(1, 3)/cos(theta_pos), R(1, 1)/cos(theta_pos));
            phi_pos = atan2(R(3, 2)/cos(theta_pos), R(2, 2)/cos(theta_pos));
            
            psi_neg = atan2(R(1, 3)/cos(theta_neg), R(1, 1)/cos(theta_neg));
            phi_neg = atan2(R(3, 2)/cos(theta_neg), R(2, 2)/cos(theta_neg));
            
        case "yxy"
            theta_pos = atan2(sqrt(R(2, 3)^2 + R(2, 1)^2), R(2, 2));
            theta_neg = atan2(-sqrt(R(2, 3)^2 + R(2, 1)^2), R(2, 2));
            
            psi_pos = atan2(R(2, 1)/sin(theta_pos), -R(2, 3)/sin(theta_pos));
            phi_pos = atan2(R(1, 2)/sin(theta_pos), R(3, 2)/sin(theta_pos));
            
            psi_neg = atan2(R(2, 1)/sin(theta_neg), -R(2, 3)/sin(theta_neg));
            phi_neg = atan2(R(1, 2)/sin(theta_neg), R(3, 2)/sin(theta_neg));
            
        case "yxz"
            theta_pos = atan2(-R(2, 3), sqrt(R(2, 2)^2 + R(2, 1)^2));
            theta_neg = atan2(-R(2, 3), -sqrt(R(2, 2)^2 + R(2, 1)^2));
            
            psi_pos = atan2(R(2, 1)/cos(theta_pos), R(2, 2)/cos(theta_pos));
            phi_pos = atan2(R(1, 3)/cos(theta_pos), R(3, 3)/cos(theta_pos));
            
            psi_neg = atan2(R(2, 1)/cos(theta_neg), R(2, 2)/cos(theta_neg));
            phi_neg = atan2(R(1, 3)/cos(theta_neg), R(3, 3)/cos(theta_neg));
            
        case "yzx"
            theta_pos = atan2(R(2, 1), sqrt(R(2, 2)^2 + R(2, 3)^2));
            theta_neg = atan2(R(2, 1), -sqrt(R(2, 2)^2 + R(2, 3)^2));

            psi_pos = atan2(-R(2, 3)/cos(theta_pos), R(2, 2)/cos(theta_pos));
            phi_pos = atan2(-R(3, 1)/cos(theta_pos), R(1, 1)/cos(theta_pos));
            
            psi_neg = atan2(-R(2, 3)/cos(theta_neg), R(2, 2)/cos(theta_neg));
            phi_neg = atan2(-R(3, 1)/cos(theta_neg), R(1, 1)/cos(theta_neg));
            
        case "yzy"
            theta_pos = atan2(sqrt(R(2, 1)^2 + R(2,3)^2), R(2, 2));
            theta_neg = atan2(-sqrt(R(2, 1)^2 + R(2,3)^2), R(2, 2));
            
            psi_pos = atan2(R(2, 3)/sin(theta_pos), R(2, 1)/sin(theta_pos));
            phi_pos = atan2(R(3, 2)/sin(theta_pos), -R(1, 2)/sin(theta_pos));
            
            psi_neg = atan2(R(2, 3)/sin(theta_neg), R(2, 1)/sin(theta_neg));
            phi_neg = atan2(R(3, 2)/sin(theta_neg), -R(1, 2)/sin(theta_neg));
            
        case "zxy"
            theta_pos = atan2(R(3, 2), sqrt(R(3, 1)^2 + R(3,3)^2));
            theta_neg = atan2(R(3, 2), -sqrt(R(3, 1)^2 + R(3,3)^2));
            
            psi_pos = atan2(-R(3, 1)/cos(theta_pos), R(3, 3)/cos(theta_pos));
            phi_pos = atan2(-R(1, 2)/cos(theta_pos), R(2, 1)/cos(theta_pos));
            
            psi_neg = atan2(-R(3, 1)/cos(theta_neg), R(3, 3)/cos(theta_neg));
            phi_neg = atan2(-R(1, 2)/cos(theta_neg), R(2, 1)/cos(theta_neg));
            
        case "zxz"
            theta_pos = atan2(sqrt(R(1, 3)^2 + R(2, 3)^2), R(3, 3));
            theta_neg = atan2(-sqrt(R(1, 3)^2 + R(2, 3)^2), R(3, 3));
            
            psi_pos = atan2(R(3, 1)/sin(theta_pos), R(3, 2)/sin(theta_pos));
            phi_pos = atan2(R(1, 3)/sin(theta_pos), -R(2, 3)/sin(theta_pos));
            
            psi_neg = atan2(R(3, 1)/sin(theta_neg), R(3, 2)/sin(theta_neg));
            phi_neg = atan2(R(1, 3)/sin(theta_neg), -R(2, 3)/sin(theta_neg));
            
        case "zyx"
            theta_pos = atan2(-R(3, 1), sqrt(R(3, 2)^2+R(3, 3)^2));
            theta_neg = atan2(-R(3, 1), -sqrt(R(3, 2)^2+R(3, 3)^2));
            
            psi_pos = atan2(R(3, 2)/cos(theta_pos), R(3, 3)/cos(theta_pos));
            phi_pos = atan2(R(2, 1)/cos(theta_pos), R(1, 1)/cos(theta_pos));
            
            psi_neg = atan2(R(3, 2)/cos(theta_neg), R(3, 3)/cos(theta_neg));
            phi_neg = atan2(R(2, 1)/cos(theta_neg), R(1, 1)/cos(theta_neg));
            
        case "zyz"
            theta_pos = atan2(sqrt(R(3, 1)^2 + R(3, 2)^2), R(3, 3));
            theta_neg = atan2(-sqrt(R(3, 1)^2 + R(3, 2)^2), R(3, 3));
            
            psi_pos = atan2(R(3, 2)/sin(theta_pos), -R(3, 1)/sin(theta_pos));
            phi_pos = atan2(R(2, 3)/sin(theta_pos), R(1, 3)/sin(theta_pos));
            
            psi_neg = atan2(R(3, 2)/sin(theta_neg), -R(3, 1)/sin(theta_neg));
            phi_neg = atan2(R(2, 3)/sin(theta_neg), R(1, 3)/sin(theta_neg));
            
        otherwise
            error("Invalid sequence");

    end
    
    % Store the solutions in vectors
    %{
    sol_1 = [
        simplify(phi_pos), 
        simplify(theta_pos), 
        simplify(psi_pos)
    ];
    sol_2 = [
        simplify(phi_neg), 
        simplify(theta_neg), 
        simplify(psi_neg)];
    %}

    sol_1 = [
        phi_pos, 
        theta_pos, 
        psi_pos
    ];
    sol_2 = [
        phi_neg, 
        theta_neg, 
        psi_neg
    ];

end