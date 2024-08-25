clc;
clear;
close all;

% Define the geometry and mesh
m = 20; % number of divisions along x
n = 20; % number of divisions along y
v1 = [0, 0];
v2 = [1, 0];
v3 = [1, 1];
v4 = [0, 1];

% This function should generate the mesh and element connectivity
[v4e, c4v] = triangle2dmesh_domain_in(m, n, v1, v2, v3, v4);

% Initialize the global stiffness matrix and load vector
numNodes = size(c4v, 1);
K = sparse(numNodes, numNodes);
F = zeros(numNodes, 1);

% Define the source function f
f = @(x, y) sin(pi * x) .* sin(pi * y);

% Number of Gaussian Quadrature points
nGQ = 3;

% Assembly of stiffness matrix and load vector
numElements = size(v4e, 2) / 2;
for e = 1:numElements
    nodes1 = v4e(:, 2*e - 1)';
    nodes2 = v4e(:, 2*e)';
    
    vtx1 = c4v(nodes1, :);
    vtx2 = c4v(nodes2, :);
    
    % Element stiffness matrix and load vector for each triangle
    Ke1 = elementStiffnessMatrix(vtx1);
    Fe1 = elementLoadVector(vtx1, f, nGQ);
    
    Ke2 = elementStiffnessMatrix(vtx2);
    Fe2 = elementLoadVector(vtx2, f, nGQ);
    
    % Assembly into the global matrices
    K(nodes1, nodes1) = K(nodes1, nodes1) + Ke1;
    F(nodes1) = F(nodes1) + Fe1;
    
    K(nodes2, nodes2) = K(nodes2, nodes2) + Ke2;
    F(nodes2) = F(nodes2) + Fe2;
end

% Apply Dirichlet boundary conditions
tol = 1e-6;
boundaryNodes = find(abs(c4v(:, 1)) < tol | abs(c4v(:, 2)) < tol | abs(c4v(:, 1) - 1) < tol | abs(c4v(:, 2) - 1) < tol);

for i = 1:length(boundaryNodes)
    node = boundaryNodes(i);
    K(node, :) = 0;
    K(node, node) = 1;
    F(node) = 0;
end

% Solve the linear system
U = K \ F;

% Reshape solution for visualization
U_reshaped = reshape(U, m+1, n+1);

% Plot the solution
figure;
surf(linspace(0, 1, n+1), linspace(0, 1, m+1), U_reshaped);
title('Solution of Poisson Equation using FEM');
xlabel('x');
ylabel('y');
zlabel('u');

% Element stiffness matrix function
function Ke = elementStiffnessMatrix(v)
    v1 = v(1, :);
    v2 = v(2, :);
    v3 = v(3, :);

    J = [v2 - v1; v3 - v1]';
    detJ = det(J);
    invJ = inv(J);
    
    dN_ref = [-1 -1; 1 0; 0 1]';
    dN_phys = invJ * dN_ref;
    
    Ke = detJ * (dN_phys' * dN_phys) / 2;
end

% Element load vector function
function Fe = elementLoadVector(v, f, nGQ)
    v1 = v(1, :);
    v2 = v(2, :);
    v3 = v(3, :);

    integrand = @(x, y) f(x, y) .* [1 - x - y, x, y]';
    Fe = GQintegral2DTriangle(integrand, v1, v2, v3, nGQ);
end

% Gaussian Quadrature for a 2D triangle function
function [pt2D, w] = GQref2Dtri(nGQ)
    if nGQ == 1
        pt2D = [1/3, 1/3];
        w = 1;
    elseif nGQ == 3
        pt2D = [1/2, 1/2; 0, 1/2; 1/2, 0];
        w = [1/3, 1/3, 1/3];
    elseif nGQ == 4
        pt2D = [1/3, 1/3; 1/5, 1/5; 3/5, 1/5; 1/5, 3/5];
        w = [-27/48, 25/48, 25/48, 25/48];
    else
        error('Unsupported number of Gaussian Quadrature points');
    end
end

% Gaussian Quadrature integral for a 2D triangle function
function integ = GQintegral2DTriangle(f, v1, v2, v3, nGQ)
    Psi1 = @(x, y) 1 - x - y;
    Psi2 = @(x, y) x;
    Psi3 = @(x, y) y;

    Jacb = [-1, 1, 0; -1, 0, 1];

    [pt2D, w] = GQref2Dtri(nGQ);

    xx = pt2D(:, 1);
    yy = pt2D(:, 2);

    change_Psi1 = Psi1(xx, yy);
    change_Psi2 = Psi2(xx, yy);
    change_Psi3 = Psi3(xx, yy);

    changeGaussDomain = change_Psi1 * v1 + change_Psi2 * v2 + change_Psi3 * v3;

    v = [v1; v2; v3];

    for i = 1:size(xx, 1)
        evalDetJacb(i) = det(Jacb * v);
    end

    evalF = f(changeGaussDomain(:, 1), changeGaussDomain(:, 2));

    suma = 0;
    for i = 1:size(changeGaussDomain, 1)
        suma = suma + w(i) * evalF(i) * evalDetJacb(i);
    end
    integ = suma;
end

