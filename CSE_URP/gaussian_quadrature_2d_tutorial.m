clc;
clear;
close all;
format long;

% Gaussian Quadrature 2D 


% 조건


f = @(x,y) (x.^2).*y.^2; %x^2 * y^2
nGQ = 5; %number of Gaussian Quadrature

true = 4/9 %Analytic answer

%{
Reference : 

GQ Wikipedia : https://en.wikipedia.org/wiki/Gaussian_quadrature#Gauss%E2%80%93Legendre_quadrature
2D GQ : https://www.physicsforums.com/threads/gaussian-quadrature-2d.977741/
%}


%{
Note that

Nax : Order of 1D Gaussian Quadrature
N : Order of 2D Gaussian Quadrature in [-1,1]x[-1,1]; N = Nax^2

%}


% 2D points, weights
[pt2D,w]=GQref2D(nGQ);
% 2D Calculate
Fxy=f(pt2D(:,1), pt2D(:,2));
approxInteg=w*Fxy



% Define Function


function [points, weights] = GQref1D(nGQ) %점과 가중치를 반환
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
    case 6
        weights = [0.360761573, 0.360761573, 0.467913935, 0.467913935, 0.171324492, 0.171324492];
        points = [0.661209386,-0.661209386, -0.238619186, 0.238619186, -0.932469514, 0.932469514];
    case 7 
        weights = [0.417959184, 0.381830051, 0.381830051, 0.279705391, 0.279705391, 0.129484966, 0.129484966];
        points = [0, 0.405845151, -0.405845151, -0.741531186, 0.741531186, -0.949107912, 0.949107912];
end
end


%{
function [pt2D,w]=GQref2D(nGQ)
% 2D from the 1D values
[ptx,wx]=GQref1D(nGQ);
[pty,wy]=GQref1D(nGQ);
%points and weights 
pt2D=[];
w=[];
for i=1:nGQ
    for j=1:nGQ
        pt2D=[pt2D; [ptx(i),pty(j)]];
        w=[w,wx(i)*wy(j)];
    end
end
end
%}

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


%{

function approx_values = GQintegral1D(f,a,b,nGQ) % f is function; a,b is bound; nGQ determine points & weights

[points, weights] = GQref1D(nGQ);

%GQ를 계산하는 부분
approx_values = ( (b-a)/2 ) * sum(weights .* f( ( (b - a) / 2 * points ) + ( (a + b) / 2) ) );

end

%}
