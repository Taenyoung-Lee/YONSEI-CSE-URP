%do_pade.m to get the Pade approximation for f(x) = e^x
f1 = inline('exp(x)','x');
M = 3; N = 2; %the degrees of Numerator Q(x) and Denominator D(x)
xo = 0; %the center of Taylor series expansion
[n,d] = padeap(f1,xo,M,N) %to get the coefficients of Q(x)/P(x)
x0 = -3.5; xf = 0.5; %left/right boundary of the interval
padeap(f1,xo,M,N,x0,xf) %to see the graphic results