function int_tri_val = integral2_triangle_exactvalue(f,c4vt)
    % compute double integral over triangular domain
    % f = integrand
    % c4vt = coordinates of the triangle (3*2 matrix)

    % coefficients in x(s,t)
    xst_s = c4vt(2,1)-c4vt(1,1); % coefficient of s
    xst_t = c4vt(3,1)-c4vt(1,1); % coefficient of t
    % coefficients in y(s,t)
    yst_s = c4vt(2,2)-c4vt(1,2); % coefficient of s
    yst_t = c4vt(3,2)-c4vt(1,2); % coefficient of t

    % area of the triangle whose vertices are (x1,y1), (x2,y2) and (x3,y3)
    Area = xst_s*yst_t-xst_t*yst_s;

    % f(s,t) = f(x(s,t), y(s,t))
    fst = @(s,t) f(c4vt(1,1)+xst_s*s+xst_t*t, c4vt(1,2)+yst_s*s+yst_t*t);

    int_tri_val = Area * integral2(fst,0,1,0,@(s) 1 - s);
end