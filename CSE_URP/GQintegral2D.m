function integ = GQintegral2D(f, v1, v2, v3, v4, nGQ)
    % Shape functions
    Psi1 = @(xi,eta) (1-xi).*(1-eta)/4;
    Psi2 = @(xi,eta) (1+xi).*(1-eta)/4;
    Psi3 = @(xi,eta) (1+xi).*(1+eta)/4;
    Psi4 = @(xi,eta) (1-xi).*(1+eta)/4;

    % Shape function derivatives
    d_Psi11 = @(xi,eta) -(1-eta)/4;
    d_Psi21 = @(xi,eta) (1-eta)/4;
    d_Psi31 = @(xi,eta) (1+eta)/4;
    d_Psi41 = @(xi,eta) -(1+eta)/4;
    d_Psi12 = @(xi,eta) -(1-xi)/4;
    d_Psi22 = @(xi,eta) -(1+xi)/4;
    d_Psi32 = @(xi,eta) (1+xi)/4;
    d_Psi42 = @(xi,eta) (1-xi)/4;

    % Gradient matrix (Jacobian Matrix)
    Jacb =@(xi,eta) [d_Psi11(xi,eta), d_Psi21(xi,eta),d_Psi31(xi,eta),d_Psi41(xi,eta);...
                      d_Psi12(xi,eta), d_Psi22(xi,eta),d_Psi32(xi,eta),d_Psi42(xi,eta)];

    % Change variable
    [pt2D, w] = GQref2D(nGQ);

    xi = pt2D(:,1);
    eta = pt2D(:,2);

    change_Psi1 = Psi1(xi,eta);
    change_Psi2 = Psi2(xi,eta);
    change_Psi3 = Psi3(xi,eta);
    change_Psi4 = Psi4(xi,eta);

    changeGaussDomain = change_Psi1*v1 + change_Psi2*v2 + change_Psi3*v3 + change_Psi4*v4;

    % Vertex matrix
    v_matrix = [v1; v2; v3; v4];

    % Evaluate Jacobian contribution for each Gauss point 
    evalDetJacb = abs(arrayfun(@(x, y) det(Jacb(x, y) * v_matrix), xi, eta)); 

    % Evaluate the function on the domain points
    evalF = f(changeGaussDomain(:,1), changeGaussDomain(:,2));

    % Apply Gauss integration formula
    % summation=0;
    % for i=1:size(changeGaussDomain,1)
    %     summation=summation+w(i)*evalF(i)*evalDetJacb(i);
    % end
    % 
    % integ = summation;
    % 벡터화
    integ = sum( (w' .* evalF) .* evalDetJacb);
end



