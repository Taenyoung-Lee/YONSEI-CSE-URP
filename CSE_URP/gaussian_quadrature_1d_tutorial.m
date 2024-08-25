clc;
clear;
close all;
format long;

% Gaussian Quadrature 1D 

% 조건
a = 0;
b = 1;
f = @(x) sin(pi * x);
nGQ = 4;
true = 2/pi %true보다는 true_value, exactvalue

% Gaussian Quadrature Calculate
GQintegral1D(f,a,b,nGQ)


% Define Function

function [points, weights] = GQref1D(nGQ) %점과 가중치를 반환, point순서대로 정렬해서 weight도 맞춰서 쓰기
switch nGQ
    case 1
        weights = 0;
        points = 2;
    case 2
        weights = [1,1];
        points = [-0.5773502691896257,	0.5773502691896257];
    case 3
        weights = [0.8888888888888888, 0.5555555555555556, 0.5555555555555556];
        points = [0, -0.7745966692414834, 0.7745966692414834];
    case 4
        weights = [0.6521451548625461, 0.6521451548625461, 0.3478548451374538, 0.3478548451374538];
        points = [-0.3399810435848563, 0.3399810435848563, -0.8611363115940526, 0.8611363115940526];
    case 5
        weights = [0.5688888888888889, 0.4786286704993665, 0.4786286704993665, 0.2369268850561891, 0.2369268850561891];
        points = [0, -0.5384693101056831, 0.5384693101056831, -0.9061798459386640, 0.9061798459386640];
    
end
end



function approx_values = GQintegral1D(f,a,b,nGQ) % f is function; a,b is bound; nGQ determine points & weights, function 자체로 저장해놓기

[points, weights] = GQref1D(nGQ);

%GQ를 계산하는 부분
approx_values = ( (b-a)/2 ) * sum(weights .* f( ( (b - a) / 2 .* points ) + ( (a + b) / 2) ) );

end