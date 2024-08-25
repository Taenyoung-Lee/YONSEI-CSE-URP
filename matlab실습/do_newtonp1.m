%do_newtonp1.m ? plot Fig.3.2
x = [-1 -0.5 0 0.5 1.0]; y = f31(x);
n = newtonp(x,y)
xx = [-1:0.02: 1]; %the interval to look over
yy = f31(xx); %graph of the true function
yy1 = polyval(n,xx); %graph of the approximate polynomial function
subplot(221), plot(xx,yy,'k-', x,y,'o', xx,yy1,'b')
subplot(222), plot(xx,yy1-yy,'r') %graph of the error function