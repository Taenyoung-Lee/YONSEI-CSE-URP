clc;
clear;
close all;

% Define the geometry and mesh for 1D domain => v4e, c4v로 뽑아오기

m = 100; % number of divisions
a = 0;   % lower bound of the domain
b = 1;   % upper bound of the domain

% Generate the nodes
v = linspace(a, b, m)';

% Initialize the global stiffness matrix and load vector
numNodes = size(v, 1);
K = sparse(numNodes, numNodes);
F = zeros(numNodes, 1);

% Define the function f
f = @(x) sin(pi * x);

% Number of Gaussian Quadrature points
nGQ = 3; % Increased the number of quadrature points

% Assembly of stiffness matrix and load vector
for e = 1:m-1
    nodes = [e, e+1];
    vtx = v(nodes);
    
    % Element stiffness matrix and load vector for each element
    Ke = elementStiffnessMatrix(vtx);
    Fe = elementLoadVector(vtx, f, nGQ);
    
    % Assembly into the global matrices
    K(nodes, nodes) = K(nodes, nodes) + Ke;
    F(nodes) = F(nodes) + Fe;
end

% Apply Dirichlet boundary conditions -> sparse(row, col, val)에서 row에
% v4e 넣고, f도 accumarray, boundary도 2:end-1; 2d에서는 interior 뽑고 setdiff로 바운더리
% 뽑음.(index로 뽑음)

% tol = 1e-6;
% boundaryNodes = find(abs(v - a) < tol | abs(v - b) < tol);
% 
% for i = 1:length(boundaryNodes)
%     node = boundaryNodes(i);
%     K(node, :) = 0;
%     K(node, node) = 1;
%     F(node) = 0;
% end

% Solve the linear system
U = K \ F; %그냥 이렇게 넣지 말고 A의 index로 (2:end-1,2:end-1), b(2:end-1)로 interior만 뽑아서 inverse. inverse 하고 start,endpoint에 0을 넣어준다.

% Plot the solution
figure;
plot(v, U, 'b.-');
hold on;
fplot(@(x) sin(pi*x), [a, b], 'r--'); % Plot exact solution
hold off;
title('Solution of Poisson Equation using FEM (1D)');
xlabel('x');
ylabel('u');

% Element stiffness matrix function for 1D using hat functions
function Ke = elementStiffnessMatrix(v)
    h = v(2) - v(1); % Element length
    Ke = [1, -1; -1, 1] / h;
end

% Element load vector function for 1D using hat functions ->
% GQIntegral1D + for/sparse/accumarray

function Fe = elementLoadVector(v, f, nGQ)
    % 1. 가우스 적분점과 가중치 가져오기
    [points, weights] = GQref1D(nGQ);
    h = v(2) - v(1); % 요소 길이
    
    % 2. 가우스 적분점과 가중치를 요소의 실제 좌표로 변환
    x_mapped = ((v(2) - v(1)) / 2) * points + ((v(2) + v(1)) / 2);
    w_mapped = (v(2) - v(1)) / 2 * weights;
    
    % 3. 가우스 적분점에서 형상 함수 계산
    N1 = 1 - ((x_mapped - v(1)) / h);
    N2 = (x_mapped - v(1)) / h;
    
    % 4. 가우스 적분점에서 함수 계산
    f_values = f(x_mapped);
    
    % 5. 가우스 적분을 사용하여 적분 계산 및 하중 벡터 계산
    Fe = [sum(w_mapped .* f_values .* N1);
          sum(w_mapped .* f_values .* N2)];
end

% 
% % Gaussian Quadrature reference points and weights for 1D
% function [points, weights] = GQref1D(n)
%     % Using standard points and weights for n-point Gaussian quadrature
%     switch n
%         case 2
%             points = [-0.5773502691896257, 0.5773502691896257];
%             weights = [1, 1];
%         case 3
%             points = [-0.7745966692414834, 0, 0.7745966692414834];
%             weights = [0.5555555555555556, 0.8888888888888888, 0.5555555555555556];
%         case 4
%             points = [-0.8611363115940526, -0.3399810435848563, 0.3399810435848563, 0.8611363115940526];
%             weights = [0.3478548451374538, 0.6521451548625461, 0.6521451548625461, 0.3478548451374538];
%         case 10
%             points = [-0.9739065285171717, -0.8650633666889845, -0.6794095682990244, -0.4333953941292472, -0.1488743389816312, 0.1488743389816312, 0.4333953941292472, 0.6794095682990244, 0.8650633666889845, 0.9739065285171717];
%             weights = [0.0666713443086881, 0.1494513491505806, 0.219086362515982, 0.2692667193099963, 0.2955242247147529, 0.2955242247147529, 0.2692667193099963, 0.219086362515982, 0.1494513491505806, 0.0666713443086881];
%         otherwise
%             error('Number of Gaussian points not supported');
%     end
%     points = points';
%     weights = weights';
% end
