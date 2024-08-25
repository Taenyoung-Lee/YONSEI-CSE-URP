% Calculation and Error

clc;
clear;
close all;

f =@(x,y) (sin((pi)*x).*sin((pi)*y));
% f = @(x,y) 1/(2*pi) * exp( -1/2 * (x.^2 + y.^2));

v1=[0,0];
v2=[1/4,0];
v3=[1/4,1/4];
v4=[0,1/4];
n = 100;
nGQ = 3;

approx = GQIntegral2D_n(f, v1, v2, v3, v4, n, nGQ);

