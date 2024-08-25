% 2D quadrature point 계산

function [pt2D, w] = GQref2D(nGQ)
% load 1D values
[ptx, wx] = GQref1D(nGQ);
[pty, wy] = GQref1D(nGQ);

% matrix operations
ptx_rep = repmat(ptx(:), 1, nGQ);
pty_rep = repmat(pty(:)', nGQ, 1);
pt2D = [ptx_rep(:), pty_rep(:)];

% Calculate weights using outer product
w = wx(:) * wy(:).';

% Reshape to a column vector
w = w(:)';


%plot(ptx_rep, pty_rep, "o")
end