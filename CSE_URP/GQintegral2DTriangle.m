function integ = GQintegral2DTriangle(f, v1, v2, v3, nGQ)
    % Shape functions
    Psi1 = @(x,y) 1 - x - y;
    Psi2 = @(x,y) x;
    Psi3 = @(x,y) y;

    % % Shape function derivatives 1,-1,0으로만 나와서 그냥 합산해서 계산
    % d_Psi1 = @(xi,eta) [-1, -1];
    % d_Psi2 = @(xi,eta) [1, 0];
    % d_Psi3 = @(xi,eta) [0, 1];

    % % Gradient matrix (Jacobian Matrix)
    % Jacb = [v2(1) - v1(1), v3(1) - v1(1);
    %         v2(2) - v1(2), v3(2) - v1(2)];
    
    % Gradient matrix
    Jacb =[-1, 1, 0; -1, 0,1];

    % Change variable
    [pt2D, w] = GQref2Dtri(nGQ);

    xx = pt2D(:,1);
    yy = pt2D(:,2);

    change_Psi1 = Psi1(xx,yy);
    change_Psi2 = Psi2(xx,yy); 
    change_Psi3 = Psi3(xx,yy);

    changeGaussDomain = change_Psi1.*v1 + change_Psi2.*v2 + change_Psi3.*v3;
    % changeGaussDomain = v1 + xi.*(v2 - v1) + eta.*(v3 - v1);

    % Calculate Jacobian contribution 4 each Gauss point 
    % evalDetJacb = abs(arrayfun(@(x, y) det(Jacb(x, y)), xi, eta));%손으로 계산해서 area값으로 넣기
    % evalDetJacb= abs(det(Jacb));

    % vertex matrix
    v = [v1;v2;v3];
    % evaluate Jacobian contribution for each point
    for i=1:size(xx,1)
        evalDetJacb(i) = det(Jacb*v);
    end

    % Calculate the function on the domain points
    evalF = f(changeGaussDomain(:,1), changeGaussDomain(:,2));

    % Apply Gauss integration formula
    suma=0;
    for i=1:size(changeGaussDomain,1)
        suma=suma+w(i)*evalF(i)*evalDetJacb(i);
    end
    integ = suma;
    
    % integ = sum((w.*evalF).*evalDetJacb); 
end