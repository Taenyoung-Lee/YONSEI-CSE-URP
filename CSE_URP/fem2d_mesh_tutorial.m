clc;
clear;
close all;

%2D fem mesh

[v4e,c4v] = fem2d(4,5); % m by n ;m은 x를 나누고 n은 y를 나누고
disp('v4e');
disp(v4e);
disp('c4v');
disp(c4v);


%그림그리기
figure; 
    hold on;
    for i = 1:size(v4e, 2)
        m = c4v(v4e(:,i), :);
        x = [m(1,1), m(2,1), m(3,1), m(4,1), m(1,1)];
        y = [m(1,2), m(2,2), m(3,2), m(4,2), m(1,2)];
        plot(x, y, 'o-');
    end
    hold off;
    axis equal;
    title('2D Finite Element Mesh');

% matrix만들기
function [v4e,c4v] = fem2d(m, n) %c4v, v4e순으로
    %v4e matrix 생성
    v4e = zeros(4, m * n); %
    i = 1;
    k = 1;
    while i < ((m)* (n+1)) %for문 while문 대신에 matrix + vector 방식 사용
        a = [i, i+1, i+n+2, i+n+1];%굳이 변수 추가 안하고 바로 추가
        if mod(i+1, n+1) == 0
            i = i + 2;
        else
            i = i + 1;
        end
        v4e(:, k) = a;
        k = k+1;
    end

    %c4v matrix 생성
    c4v = zeros((n+1)*(m+1),2);
    
    g = 0;%변수명을 수정
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










