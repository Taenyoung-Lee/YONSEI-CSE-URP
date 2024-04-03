clc;
close all;
clear;


m = 3; 
n = 2; 


a = linspace(0,1,m+1);
a1 = repmat(a',m,1);


%여기서 한 element의 가로 길이는 1/m 이하 이므로, t(좌우변화폭)은 t<(1/m)
t = rand;
while t >= 1/m
    t = rand;
end

%n이 odd number라면, 
a2 = a;
a2(:,2:end-1) = a(:,2:end-1) + t;
    
col1 = reshape([a,a2],[],1);
col1 = repmat(col1,floor((n+1)/2),1); %floor을 사용하여 임의의 n에 대해서도 동작.
if mod(n,2) == 0 %n이 even number 라면,
    col1 = [col1;a'];

end

aa = linspace(0,1,n+1); %세로값의 변화는 trapezoidal에서 없다.
aa1 = repelem(aa',length(a),1); %세로값의 변화는 trapezoidal에서 없다.

c4v = [col1,aa1]
