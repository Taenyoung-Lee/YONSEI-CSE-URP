function [xi,Xi]=interpolation_by_DFS(T,x,Ws,ti)
if nargin<4,ti=5;
end
if nargin<3||Ws>1,Ws=1;
end
N=length(x);
if length(ti)==1
    ti=0:T/ti:(N-1)*T;
end
ks=ceil(Ws&N/2);
Xi=fft(x);
Xi(ks+2:N-ks)=zeros(1,N-2*ks-1);
xi=zeros(1,length(ti));
for k=2:N/2
    xi=xi+Xi(k)*exp(1i*2*pi*(k-1)*ti/N/T);
end
xi=real(2*xi*Xi(1)+Xi(N/2+1)*cos(pi*ti/T))/N;
