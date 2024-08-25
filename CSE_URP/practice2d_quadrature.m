clc;
clear;
close all;

% 조건

% 함수
%F =@(x,y) (x.^2) + y.^2;
% F =@(x,y) (sin((pi)*x).*sin((pi)*y));
F = @(x,y) 1/(2*pi) * exp( -1/2 * (x.^2 + y.^2));
% domain vertices

v1=[-10,-10];
v2=[10,-10];
v3=[10,10];
v4=[-10,10];


% Shape functions
Psi1=@(xi,eta)(1-xi).*(1-eta)/4;
Psi2=@(xi,eta)(1+xi).*(1-eta)/4;
Psi3=@(xi,eta)(1+xi).*(1+eta)/4;
Psi4=@(xi,eta)(1-xi).*(1+eta)/4;

% Shape function derivatives(손으로 계산)
d_Psi11=@(xi,eta) -(1-eta)/4;
d_Psi21=@(xi,eta) (1-eta)/4;
d_Psi31=@(xi,eta) (1+eta)/4;
d_Psi41=@(xi,eta) -(1+eta)/4;
d_Psi12=@(xi,eta) -(1-xi)/4;
d_Psi22=@(xi,eta) -(1+xi)/4;
d_Psi32=@(xi,eta) (1+xi)/4;
d_Psi42=@(xi,eta) (1-xi)/4;
% Gradient matrix(Jacobian Matrix)
Jacb =@(xi,eta) [d_Psi11(xi,eta), d_Psi21(xi,eta),d_Psi31(xi,eta),d_Psi41(xi,eta);...
              d_Psi12(xi,eta), d_Psi22(xi,eta),d_Psi32(xi,eta),d_Psi42(xi,eta)];


% Change variable
[pt2D, w] = GQref2D(5);

xi = pt2D(:,1);
eta = pt2D(:,2);

change_Psi1 = Psi1(xi,eta);
change_Psi2 = Psi2(xi,eta);
change_Psi3 = Psi3(xi,eta);
change_Psi4 = Psi4(xi,eta);

changeGaussDomain = change_Psi1*v1+change_Psi2*v2+change_Psi3*v3+change_Psi4*v4;



%check change variable plot

% Draw Gauss points in the present domain
figure()
vertices=[v1;v2;v3;v4;v1];
plot(vertices(:,1), vertices(:,2));
hold on;
plot(changeGaussDomain(:,1),changeGaussDomain(:,2),'ro');
hold off;


%vertex matrix
v = [v1;v2;v3;v4];

% evaluate Jacobian contribution for each Gauss point 

% for i=1:size(xi,1)
%     evalDetJacb(i) = abs(det( Jacb(xi(i),eta(i)) *v ) );
% end

% 위 loop을 벡터화
evalDetJacb = abs(arrayfun(@(x, y) det(Jacb(x, y) * v), xi, eta));



% Evaluate the function on the domain points
evalF=F(changeGaussDomain(:,1),changeGaussDomain(:,2));
 
% Apply Gauss integration formula
summation=0;
for i=1:size(changeGaussDomain,1)
    summation=summation+w(i)*evalF(i)*evalDetJacb(i);
end

integ = summation
% only for 4 vertex?? <=> only for nGQ=2??


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

