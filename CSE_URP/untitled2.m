clc;
clear;
close all;

% Define the geometry and mesh for 1D domain
m = 10; % number of divisions
a = 0;   % lower bound of the domain
b = 1;   % upper bound of the domain

% Generate the nodes
v = linspace(a, b, m)';

% Define the connectivity matrix v4e
v4e = [1:m-1; 2:m];

% Define the coordinates matrix c4v
c4v = [v, zeros(m, 1)]; % 1D problem, y-coordinates are  0

% global stiffness matrix and load vector
numNodes = size(v, 1);
numElements = size(v4e, 2);
%K = sparse(numNodes, numNodes);
%F = zeros(numNodes, 1);

% Define the function f
f = @(x) sin(pi * x);
u = @(x) sin(pi *x)/(pi^2);
% Number of Gaussian Quadrature points
nGQ = 5; % Increased the number of quadrature points

% Precompute element stiffness matrices and load vectors
% Ke_all = zeros(2, 2, numElements);
Fe_all = zeros(2, numElements);

for e = 1:numElements
    nodes = v4e(:, e)';
    % Ke_all(:, :, e) = elementStiffnessMatrix(v(nodes));
    Fe_all(:, e) = elementLoadVector(v(nodes), f, nGQ, 1);
end

% % Assemble global stiffness matrix using sparse
% rows = reshape(repmat(v4e(:), 2, 1), [], 1);
% cols = reshape(repmat(v4e(:)', 2, 1), [], 1);
% values = reshape(Ke_all, [], 1);
% K = sparse(rows, cols, values, numNodes, numNodes);

Ke_all = zeros(4,numElements);
for e = 1:numElements
    nodes = v4e(:, e)';
    stiff = elementStiffnessMatrix(v(nodes));
    Ke_all(:,e) = stiff(:);
end

row = repmat(v4e,2,1);
col = repelem(v4e,2,1);
K = sparse(row, col, Ke_all);

% Assemble global load vector using accumarray
F = accumarray(v4e(:), Fe_all(:), [numNodes, 1]);


% % Assemble global stiffness matrix using sparse
% rows = reshape(repmat(v4e(:)', 2, 1), [], 1);
% cols = reshape(repmat(v4e(:), 1, 2)', [], 1);
% values = reshape(permute(Ke_all, [3, 1, 2]), [], 1);
% K = sparse(rows, cols, values, numNodes, numNodes);
% 
% % Assemble global load vector using accumarray
% rows_F = reshape(repmat(v4e(:)', 1, 1), [], 1);
% values_F = reshape(Fe_all, [], 1);
% F = accumarray(rows_F, values_F, [numNodes, 1]);


% Apply boundary conditions
interiorNodes = 2:numNodes-1;
boundaryNodes = [1, numNodes];
interiorNodes = setdiff(interiorNodes, boundaryNodes);

% Extract submatrices for interior nodes
K_interior = K(interiorNodes, interiorNodes);
F_interior = F(interiorNodes);

% Solve the linear system for interior nodes
U_interior = K_interior \ F_interior;

% Combine the solution with boundary conditions
U = zeros(numNodes, 1);
U(interiorNodes) = U_interior;

% Plot the solution
figure;
plot(v, U, 'b.-');
hold on;
fplot(@(x) u(x), [a, b], 'r--'); % Plot exact solution
hold off;
title('Solution of Poisson Equation using FEM (1D)');
xlabel('x');
ylabel('u');

% Element stiffness matrix function for 1D using hat functions
function Ke = elementStiffnessMatrix(v)
    h = v(2) - v(1); % Element length
    Ke = [1, -1; -1, 1] / h;
end

% Element load vector function for 1D using hat functions
function Fe = elementLoadVector(v, f, nGQ, n)
    % Calculate the integral using Gaussian quadrature
    N1 = @(x) 1 - (x - v(1)) / (v(2) - v(1));
    N2 = @(x) (x - v(1)) / (v(2) - v(1));
    
    Fe1 = GQIntegral1D(@(x) f(x) .* N1(x), v(1), v(2), nGQ, n);
    Fe2 = GQIntegral1D(@(x) f(x) .* N2(x), v(1), v(2), nGQ, n);
    
    Fe = [Fe1; Fe2];
end
