  %v4e, c4v로 잘 불러와 지는지 확인해보기 위한 코드 

clc;
   clear;
   close all;

    nGQ = 3;
    v1=[0,0];
    v2=[1,0];
    v3=[1,1];
    v4=[0,1];
    
    
    n = 3;
    [v4e, c4v] = triangle2dmesh_domain(n, n, v1, v2, v3, v4);
    
    temp1 = c4v(v4e(1,:),:);
    temp2 = c4v(v4e(2,:),:);
    temp3 = c4v(v4e(3,:),:);
    for i =  1 : (2*(n^2))
        v1_mesh = [temp1(i,:)];

        v2_mesh = [temp2(i,:)];
        v3_mesh = [temp3(i,:)];

        disp(v1_mesh);
        disp(v2_mesh);
        disp(v3_mesh);

    end




%%%%% GQintegral2DTriangle 확인해보기 위한 코드 
clc;
clear;
close all;
f = @(x,y) (sin((pi)*x).*sin((pi)*y));

nGQ = 3;
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];


approx_integ = GQintegral2DTriangle(f,v1,v2,v3,nGQ);
disp(approx_integ);

function integ = GQintegral2DTriangle(f, v1, v2, v3, nGQ)
    % Shape functions
    Psi1 = @(xi,eta) 1 - xi - eta;
    Psi2 = @(xi,eta) xi;
    Psi3 = @(xi,eta) eta;


    % Gradient matrix (Jacobian Matrix)
    Jacb = [v2(1) - v1(1), v3(1) - v1(1);
            v2(2) - v1(2), v3(2) - v1(2)];

    % Change variable
    [pt2D, w] = GQref2Dtri(nGQ);

    xi = pt2D(:,1);
    eta = pt2D(:,2);

    change_Psi1 = Psi1(xi,eta);
    change_Psi2 = Psi2(xi,eta); 
    change_Psi3 = Psi3(xi,eta);

    changeGaussDomain = v1 + change_Psi1.*v1 + change_Psi2.*v2 + change_Psi3.*v3;

    % Calculate Jacobian contribution 4 each Gauss point 
   
    evalDetJacb= abs(det(Jacb));
    % Calculate the function on the domain points
    evalF = f(changeGaussDomain(:,1), changeGaussDomain(:,2));

   
    
    integ = sum((w.*evalF)*evalDetJacb); 
end