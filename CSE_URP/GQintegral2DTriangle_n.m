function integ = GQintegral2DTriangle_n(f, v1, v2, v3, v4, n, nGQ)
    
    [v4e, c4v] = triangle2dmesh_domain(n, n, v1, v2, v3, v4);
    
    temp1 = c4v(v4e(1,:),:);
    temp2 = c4v(v4e(2,:),:);
    temp3 = c4v(v4e(3,:),:);  

    integral_sum = 0;

    for i =  1 : (2*(n^2))
        v1_mesh = [temp1(i,:)];
        v2_mesh = [temp2(i,:)];
        v3_mesh = [temp3(i,:)];

        
        % Calculate the integral for the current mesh using GQIntegral2D
        integral_mesh = GQintegral2DTriangle(f, v1_mesh, v2_mesh, v3_mesh, nGQ);
    
        % Add the integral of the current mesh to the total integral sum
        integral_sum = integral_sum + integral_mesh;

    end

    % Return the total integral sum
    integ = integral_sum;
end