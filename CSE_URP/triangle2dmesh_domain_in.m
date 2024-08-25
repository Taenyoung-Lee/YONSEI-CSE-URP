% clc;
% clear;
% close all;
% 
% %확인용 그림그리기
% m = 4;
% n = 4;
% v1=[0,0];
% v2=[1,0];
% v3=[1,1];
% v4=[0,1];
% 
% [v4e, c4v] = triangle2dmesh_domain_in(m, n, v1, v2, v3, v4);
% 
% figure; 
% hold on;
% for i = 1:size(v4e, 2)
%     v = c4v(v4e(:, i), :);
%     x = v(:, 1);
%     y = v(:, 2);
% 
%     %삼각형의 각 선분을 그리기
%     plot([x(1), x(2)], [y(1), y(2)], 'o-');
%     plot([x(2), x(3)], [y(2), y(3)], 'o-');
%     plot([x(3), x(1)], [y(3), y(1)], 'o-');
% end
% hold off;
% axis equal;
% title('2D Finite Element Triangle Mesh');
% 
% 

function [v4e, c4v] = triangle2dmesh_domain_in(m, n, v1, v2, v3, v4)
    % % v4e matrix 생성
    % v1_idx = repmat((0:m-1)*(n+1), n, 1)' + repmat(1:n, m, 1);
    % v2_idx = v1_idx + 1;
    % v3_idx = v1_idx + n + 2;
    % v4_idx = v3_idx - 1;
    % v4e = reshape([v1_idx(:), v2_idx(:), v3_idx(:), v2_idx(:), v4_idx(:), v3_idx(:)]', 3, []);


    v4e = zeros(3, m * n );
    i = 1;
    k = 1;
    while i < ((m)* (n+1))
        % if s == 'n'
        %     a = [i, i+n+1 ; i+1, i+1; i + n+1, i+n+2];
        % end
        % if s == 'p'
        %     a = [i, i+n+2 ; i+n+2, i; i + n+1, i+1];
        % end

        a = [i, i+n+1 ; i+1, i+1; i + n+1, i+n+2];
        if mod(i+1, n+1) == 0
            i = i + 2;
        else
            i = i + 1;
        end
        v4e(:, k:k+1) = a;
        k = k+2;
    end

    % mat = reshape(1:(m+1)*(n+1),m+1,n+1);
    % v = mat(1:end-1, 1:end-1);
    % 
    % v4e = v(:);  % Reshape v into a column vector and transpose
    % 
    % v4e = [v4e; v4e(1,:) + 1; v4e(1,:) + m+1 + 1; v4e(1,:) + m+1];


    %c4v matrix 생성
    % c4v = zeros((n+1)*(m+1),2);
    % 
    % g = 0;
    % h = 0;
    % for c = 1 : (n+1)*(m+1)
    %     c4v(c,1) = g;
    %     g = g + (1/n);
    %     if g > 1
    %         g = 0;
    %         h = h + (1/m);
    %         c4v(c+1:end,2) = h;
    % 
    %     end
    % end

    a = linspace(v1(1),(v2(1) - v1(1)),n+1);
    aa = linspace(v1(2),(v4(2) - v1(2)),m+1);
    a1 = repmat(a',m+1,1);
    a2 = repelem(aa',n+1,1);

    c4v = [a1,a2];

end





