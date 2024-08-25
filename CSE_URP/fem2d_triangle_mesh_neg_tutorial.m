clc;
clear;
close all;

%2D fem mesh

[v4e, c4v] = fem2d(5,7); % m by n
disp('v4e');
disp(v4e);
disp('c4v');
disp(c4v);


%그림그리기

figure; 
patch('Vertices', c4v, 'Faces', v4e', 'FaceColor', 'white');
figure;

for i = 1:size(v4e, 2)
    v = c4v(v4e(:, i), :);
    x = v(:, 1);
    y = v(:, 2);
    
    % 삼각형의 각 선분을 그리기
    plot([x(1), x(2)], [y(1), y(2)], 'o-');
    hold on;
    plot([x(2), x(3)], [y(2), y(3)], 'o-');
    plot([x(3), x(1)], [y(3), y(1)], 'o-');
end
hold off;
axis equal;
title('2D Finite Element Triangle Mesh');
% matrix만들기(음의 기울기 일 경우)
function [v4e, c4v] = fem2d(m, n)%삼각형에는 v4e대신 v4tri
    %v4e matrix 생성
    v4e = zeros(3, m * n );
    i = 1;
    k = 1;
    while i < ((m)* (n+1))
        a = [i, i+n+1 ; i+1, i+1; i + n+1, i+n+2]; %triangle 순서를 1,2,9 10,9,2 방향
        disp(a);
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