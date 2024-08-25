N = 1000; x = rand(1,N); 
W = [-100:100]*pi/100; 
tic
 for k = 1:length(W)
  X1(k) = 0;
  for n = 1:N, X1(k) = X1(k) + x(n)*exp(-j*W(k)*(n-1)); end
end
toc
tic
X2 = 0;
 for n = 1:N 
 X2 = X2 +x(n)*exp(-j*W*(n-1));
end
toc
discrepancy = norm(X1-X2) 