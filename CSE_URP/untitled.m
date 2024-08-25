clc;
clear;
close all;

% Define the geometry and mesh for 1D domain
m = 100; % number of node
a = 0;   % lower bound of the domain
b = 1;   % upper bound of the domain


v = linspace(a, b, m);

v4e(1,:) = (1:m-1);
v4e(2,:) = v4e(1,:) + 1;

c4v(:,1) = repmat(v',1,1);
c4v(:,2) = 0;



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

% Apply Dirichlet boundary conditions
interiorNodes = 2:numNodes-1;
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

% Element load vector function for 1D using hat functions
function Fe = elementLoadVector(v, f, nGQ)
    % Calculate the integral using Gaussian quadrature
    N1 = @(x) 1 - (x - v(1)) / (v(2) - v(1));
    N2 = @(x) (x - v(1)) / (v(2) - v(1));
    
    Fe1 = GQIntegral1D(@(x) f(x) .* N1(x), v(1), v(2), nGQ);
    Fe2 = GQIntegral1D(@(x) f(x) .* N2(x), v(1), v(2), nGQ);
    
    Fe = [Fe1; Fe2];
end

% Gaussian Quadrature Integration function for 1D
function I = GQIntegral1D(f, a, b, nGQ)

    
    % Map from reference interval [-1, 1] to [a, b]
    I = 0;
    for i = 1:nGQ
        x = 0.5 * ((b - a) * xGQ(i) + (b + a));
        I = I + wGQ(i) * f(x);
    end
    
    % Scale by the length of the interval
    I = I * 0.5 * (b - a);
end




