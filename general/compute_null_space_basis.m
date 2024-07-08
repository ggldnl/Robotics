function null_space_basis = compute_null_space_basis(J)

    % For symbolic J, use the null function from the Symbolic Math Toolbox
    null_space_basis = null(J);

    %{
    dim_null_space=size(null_space_basis,2);
    
    disp("Normalizing...")
    if dim_null_space > 1
        % Normalize each component of the vector
        null_space_basis(:,1)=null_space_basis(:,1)/norm(null_space_basis(:,1));
        null_space_basis(:,2)=null_space_basis(:,2)/norm(null_space_basis(:,2));
    else
        null_space_basis=null_space_basis/norm(null_space_basis);
    end
    
    disp("Null Space basis");
    null_space_basis=simplify(null_space_basis)
    
    disp("Dimension of the Null Space")
    dim_null_space=size(null_space_basis,2)
    %}

end
