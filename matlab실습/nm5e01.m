%nm5e01:Nth-order Taylor series expansion for e^-x about xo in Ex 5.1
f=inline('exp(-x)','x');
N = 5; xo = 0;
%Numerical computation method
T(1) = feval(f,xo);
h = 0.005 %.01 or 0.001 make it worse
tmp = 1;
for i = 1:N
tmp = tmp*i*h; %i!(factorial i)*h^i
c = difapx(i,[-i i]); %coefficient of numerical derivative
dix = c*feval(f,xo + [-i:i]*h)'; %/h^i; %derivative
T(i+1) = dix/tmp; %Taylor series coefficient
end
format rat, Tn = fliplr(T) %descending order
%Symbolic computation method
syms x; Ts = sym2poly(taylor(exp(-x),N + 1,xo))
%discrepancy
format short, discrepancy=norm(Tn - Ts)