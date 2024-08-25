function [x,err,xx]=fixpt(g,x0,TolX,MaxIter)
if nargin <4 , MaxIter=100; end
if nargin <3,  TolX=1e-6; end
xx(1)=x0;
for k=2:MaxIter
    xx(k)=feval(g,xx(k-1));
    err=abs(xx(k)-xx(k-1));
    if err<TolX, break;
    end
end
x=xx(k);
if k==MaxIter
    fprintf('Do not rely on me, though best in %d iteration\n',MaxlTer)
end
