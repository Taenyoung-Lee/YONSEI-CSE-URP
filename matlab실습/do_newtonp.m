%do_newtonp.m
x = [-2 -1 1 2 4]; y = [-6 0 0 6 60];
n = newtonp(x,y) %l = lagranp(x,y) for comparison
x = [-1 -2 1 2 4]; y = [ 0 -6 0 6 60];
n1 = newtonp(x,y) %with the order of data changed for comparison
xx = [-2:0.02: 2]; yy = polyval(n,xx);
clf, plot(xx,yy,'b-',x,y,'*')