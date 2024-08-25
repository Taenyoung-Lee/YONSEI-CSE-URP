clc;
clear;
close all;
format long;

% Gaussian Quadrature 2D 

% 조건


%f = @(x,y) (x.^2).*y.^2; %x^2 * y^2
f = @(x,y) (sin(pi.*x).*sin(pi.*y)) ; %sin(pi)x * sin(pi)y
nGQ = 3; %number of Gaussian Quadrature
% 
% true = 0 %Analytic answer
approx_values = GQintegral2D(f,nGQ);

approx_values





%for loop 대신 벡터화

function [pt2D, w] = GQref2D(nGQ)
% load 1D values
[ptx, wx] = GQref1D(nGQ);
[pty, wy] = GQref1D(nGQ);

% matrix operations
ptx_rep = repmat(ptx(:), 1, nGQ);
pty_rep = repmat(pty(:)', nGQ, 1);
pt2D = [ptx_rep(:), pty_rep(:)];

% Calculate weights using outer product
w = wx(:) * wy(:).';

% Reshape to a column vector
w = w(:)';


%plot(ptx_rep, pty_rep, "o")
end

% 2D Calculate
function approx_values = GQintegral2D(f,nGQ) % f is function; a,b is bound; nGQ determine points & weights, function 자체로 저장해놓기
% 2D points, weights
[pt2D,w]=GQref2D(nGQ);

Fxy=f(pt2D(:,1), pt2D(:,2));
approx_values=w*Fxy;
end


