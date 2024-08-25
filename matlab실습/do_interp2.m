%do_interp2.m
% 2-dimensional interpolation for Ex 3.5
xi = -2:0.1:2; yi = -2:0.1:2;
[Xi,Yi] = meshgrid(xi,yi);
Z0 = Xi.^2 + Yi.^2; %(E3.5.1)
subplot(131), mesh(Xi,Yi,Z0)
x = -2:0.5:2; y = -2:0.5:2;
[X,Y] = meshgrid(x,y);
Z = X.^2 + Y.^2;
subplot(132), mesh(X,Y,Z)
Zi = interp2(x,y,Z,Xi,Yi); %built-in routine
subplot(133), mesh(xi,yi,Zi)
Zi = intrp2(x,y,Z,xi,yi); %our own routine
pause, mesh(xi,yi,Zi)
norm(Z0 - Zi)/norm(Z0)