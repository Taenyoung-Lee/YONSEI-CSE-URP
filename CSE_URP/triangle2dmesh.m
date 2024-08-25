% matrix만들기(양의 기울기 일 경우)
function [v4e, c4v] = triangle2dmesh(m, n)
    %v4e matrix 생성
    v4e = zeros(3, m * n );
    i = 1;
    k = 1;
    while i < ((m)* (n+1))
        a = [i, i+n+2 ; i+n+2, i; i + n+1, i+1];
        % disp(a);
        if mod(i+1, n+1) == 0
            i = i + 2;
        else
            i = i + 1;
        end
        v4e(:, k:k+1) = a;
        k = k+2;
    end

    %c4v matrix 생성
  
    c4v = zeros((n+1)*(m+1),2);
    
    g = 0;
    h = 0;
    for c = 1 : (n+1)*(m+1)
        c4v(c,1) = g;
        g = g + (1/n);
        if g > 1
            g = 0;
            h = h + (1/m);
            c4v(c+1:end,2) = h;
            
        end
    end
end