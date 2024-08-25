function x = gauss(A,B)
%The sizes of matrices A,B are supposed to be NA x NA and NA x NB.
%This function solves Ax = B by Gauss elimination algorithm.
NA = size(A,2); [NB1,NB] = size(B);
if NB1 ~= NA, error('A and B must have compatible dimensions'); end
N = NA + NB; AB = [A(1:NA,1:NA) B(1:NA,1:NB)]; % Augmented matrix
epss = eps*ones(NA,1);
for k = 1:NA
%Scaled Partial Pivoting at AB(k,k) by Eq.(2.2.20)
[akx,kx] = max(abs(AB(k:NA,k))./ ...
max(abs([AB(k:NA,k + 1:NA) epss(1:NA - k + 1)]'))');
if akx < eps, error('Singular matrix and No unique solution'); end
mx = k + kx - 1;
if kx > 1 % Row change if necessary
tmp_row = AB(k,k:N);
AB(k,k:N) = AB(mx,k:N);
AB(mx,k:N) = tmp_row;
end
% Gauss forward elimination
AB(k,k + 1:N) = AB(k,k+1:N)/AB(k,k);
AB(k,k) = 1; %make each diagonal element one
for m = k + 1: NA
AB(m,k+1:N) = AB(m,k+1:N) - AB(m,k)*AB(k,k+1:N); %Eq.(2.2.5)
AB(m,k) = 0;
end
end
%backward substitution for a upper-triangular matrix eqation
% having all the diagonal elements equal to one
x(NA,:) = AB(NA,NA+1:N);
for m = NA-1: -1:1
x(m,:) = AB(m,NA + 1:N)-AB(m,m + 1:NA)*x(m + 1:NA,:); %Eq.(2.2.7)
end