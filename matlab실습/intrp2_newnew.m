function Zi = intrp2_newnew(x,y,Z,xi,yi)
%To interpolate Z(x,y) on (xi,yi)
M = length(x); N = length(y);
Mi = length(xi); Ni = length(yi);

 Zi = zeros(Mi,Ni);
 
for mi = 1:Mi
for ni = 1:Ni
    
    break1 = 0;
     
    for m = 2:M
        
        if break1 > 0 
            break;
        end    
            
        for n = 2:N
           
            if xi(mi) <= x(m) && yi(ni) <= y(n)
                

          tmp = (x(m)-xi(mi))*(y(n)-yi(ni))*Z(m - 1,n - 1)...
            +(xi(mi) - x(m-1))*(y(n) - yi(ni))*Z(m,n-1)...
            +(x(m) - xi(mi))*(yi(ni) - y(n - 1))*Z(m - 1,n)...
            +(xi(mi) - x(m-1))*(yi(ni) - y(n-1))*Z(m,n);
            Zi(mi,ni) = tmp/(x(m) - x(m-1))/(y(n) - y(n-1)); %Eq.(3.7.2)

             break1 = 1;
             
            end

            if break1 > 0 
                break; 
            end           
        end
   end
    
end
end
end





