N=100000;
th=[0:N-1]/50000*pi;
tic
ss=sin(th(1));
for i=2:N, ss= ss+sin(th(i));
end
toc,ss
tic
ss=sum(sin(th));
toc,ss
