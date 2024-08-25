%nm5e02
%use quad()/quad8() and int() to get CtFS coefficient X16 in Ex 5.2
ftn = 'exp(-j*k*w0*t)'; fcos = inline(ftn,'t','k','w0');
P = 4; k = 16; w0 = 2*pi/P;
a = -1; b = 1; tol = 0.001; trace = 0;
X16_quad = quad(fcos,a,b,tol,trace,k,w0)
X16_quadl = quadl(fcos,a,b,tol,trace,k,w0)
syms t; % declare symbolic variable
Iexp = int(exp(-j*k*w0*t),t) % symbolic indefinite integral
Icos = int(cos(k*w0*t),t) % symbolic indefinite integral
X16_sym = int(cos(k*w0*t),t,-1,1) % symbolic definite integral
