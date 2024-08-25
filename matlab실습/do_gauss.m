%do_gauss
A = [0 1 1;2 -1 -1;1 1 -1]; b = [2 0 1]'; %Eq.(2.2.8)
x = gauss(A,b)
x1 = A\b %for comparison with the result of backslash operation