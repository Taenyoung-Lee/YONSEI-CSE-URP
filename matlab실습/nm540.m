%nm540
% to interpolate by Lagrange polynomial and get the derivative
clear, clf
x0 = pi/4;
df0 = cos(x0); % True value of derivative of sin(x) at x0 = pi/4
for m = 1:3
    if m == 1, x = [1:3]*pi/8;
    elseif m == 2, x = [0:4]*pi/8;
    else x = [2:6]*pi/16;
    end
    y = sin(x);
    px = lagranp(x,y); % Lagrange polynomial interpolating (x,y)
    dpx = polyder(px); % derivative of polynomial px
    dfx = polyval(dpx, x0);
    fprintf('dfx(%6.4f) = %10.6f (error : %10.6f)\n', x0, dfx, dfx-df0);
end