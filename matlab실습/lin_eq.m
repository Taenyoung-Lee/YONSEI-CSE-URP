function x=lin_eq(A,B)
[M,N]=size(A);
if size(B,1)~=M
    error('Incompatible dimension of A and B in lin_eq()!')
end
if M==N,x=A^-1*B;
elseif M<N 
    x=pinv(A)*B;
else 
    x=pinv(A)*B;
end
