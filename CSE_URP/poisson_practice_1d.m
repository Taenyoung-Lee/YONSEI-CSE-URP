clc;
clear;
close all;

% Define the geometry and mesh for 1D domain
m = 100; % number of divisions
a = 0;   % lower bound of the domain
b = 1;   % upper bound of the domain

% Generate the nodes
v = linspace(a, b, m)';

% Initialize the global stiffness matrix and load vector
numNodes = size(v, 1);
K = sparse(numNodes, numNodes);
F = zeros(numNodes, 1);

% Define the source function f
f = @(x) sin(pi * x);

% Number of Gaussian Quadrature points
nGQ = 10; % Increased the number of quadrature points

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
tol = 1e-6;
boundaryNodes = find(abs(v - a) < tol | abs(v - b) < tol);

for i = 1:length(boundaryNodes)
    node = boundaryNodes(i);
    K(node, :) = 0;
    K(node, node) = 1;
    F(node) = 0;
end

% Solve the linear system
U = K \ F;

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
    Ke = zeros(2, 2);
    Ke(1, 1) = 1 / 3 * h;
    Ke(1, 2) = 1 / 6 * h;
    Ke(2, 1) = 1 / 6 * h;
    Ke(2, 2) = 1 / 3 * h;
end

% Element load vector function for 1D using hat functions
function Fe = elementLoadVector(v, f, nGQ)
    [points, weights] = GQref1D(nGQ);
    h = v(2) - v(1); % Element length
    
    % Mapping Gaussian Quadrature points and weights to the element
    x_mapped = ((v(2) - v(1)) / 2) * points + ((v(2) + v(1)) / 2);
    w_mapped = (v(2) - v(1)) / 2 * weights;
    
    % Evaluate the function at mapped points
    f_values = f(x_mapped);
    
    % Compute the approximate integral using Gaussian Quadrature
    Fe = h / 2 * sum(w_mapped .* f_values);
end

