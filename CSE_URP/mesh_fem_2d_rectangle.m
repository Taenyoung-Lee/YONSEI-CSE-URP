function [c4n, n4e, ind4e, inddb] = mesh_fem_2d_rectangle(xl, xr, yl, yr, Mx, My, k)

ind4e = zeros(Mx*My, (k+1)^2);
tmp = repmat((1:k:k*Mx)', 1, My) ...
    + repmat((0:k*(k*Mx+1):((k*Mx+1)*((My-1)*k+1)-1)), Mx, 1);
tmp = tmp(:);
for j=1:k+1
    ind4e(:,(j-1)*(k+1)+(1:(k+1))) = repmat(tmp+(j-1)*(k*Mx+1), 1, k+1) ...
        + repmat((0:k), Mx*My, 1);
end


% n4e
n4e = ind4e(:,[1 k+1 (k+1)^2 (k*(k+1)+1)]);

% indDb
inddb = [1:(k*Mx+1), 2*(k*Mx+1):(k*Mx+1):(k*Mx+1)*(k*My+1), ...
                ((k*Mx+1)*(k*My+1)-1):-1:(k*My*(k*Mx+1)+1), ...
                ((k*My-1)*(k*Mx+1)+1):-(k*Mx+1):(k*Mx+2)]';

% c4n
x = linspace(xl, xr, k*Mx+1);
y = linspace(yl, yr, k*My+1);
y = repmat(y, k*Mx+1, 1);
x = repmat(x, k*My+1, 1)';
c4n = [x(:), y(:)];
end