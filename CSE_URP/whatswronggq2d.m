clc;
clear;
close all;

F = @(x,y) (1/sqrt(2*pi)) * exp( (-1/2) * ( (x.^2) + (y.^2) ) ); % 이변량 정규분포 => 전체범위 적분하면 1
% domain vertices

v1=[-10,-10];
v2=[10,-10];
v3=[10,10];
v4=[-10,10];

% v1=[-1,-1];
% v2=[1,-1];
% v3=[1,1];
% v4=[-1,1];

approx = GQIntegral2D_n(F, v1, v2, v3, v4, 100 , 4);
approx
true_value = 1;

true_value = integral2(F,-Inf,Inf,-Inf,Inf)
