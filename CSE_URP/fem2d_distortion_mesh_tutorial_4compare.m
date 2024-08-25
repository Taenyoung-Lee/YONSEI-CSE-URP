clc;
clear;
close all;

%2D distortion fem mesh

[c4v,v4e] = distor2dmesh(10000,10000); % m by n; m이 가로


%{
disp('v4e');
disp(v4e);
disp('c4v');
disp(c4v);

%그림그리기

figure; 
patch('Vertices', c4v, 'Faces', v4e', 'FaceColor', 'none', 'EdgeColor', 'b');
axis equal;
grid on;
%}
% matrix만들기
function [c4v,v4e] = distor2dmesh(m, n)
    %v4e matrix 생성
    mat = reshape(1:(m+1)*(n+1),m+1,n+1);
    v = mat(1:end-1, 1:end-1);
    v4e = v(:)';  % Reshape v into a column vector and transpose
    v4e = [v4e; v4e(1,:) + 1; v4e(1,:) + m+1 + 1; v4e(1,:) + m+1];



    %c4v matrix 생성

    a = linspace(0,1,m+1);
    aa = linspace(0,1,n+1);
    a1 = repmat(a',n+1,1);
    a2 = repelem(aa',length(a),1);

    c4v = [a1,a2];
    

    
    
    for i = 1:size(c4v, 1)
    % 1열과 2열에 0과 1이 모두 없는 경우에만 연산 수행
        if all(c4v(i, :) ~= 0 & c4v(i, :) ~= 1)
        % 각 열에 randn 값 더하기
            c4v(i, 1) = c4v(i, 1) + randn*(1/n)*(1/m)*(1/2);
            c4v(i, 2) = c4v(i, 2) + randn*(1/n)*(1/m)*(1/2);
        end
    end
    %{   
    
    
    % 조건을 만족하는 행 선택
    condition = all(c4v ~= 0 & c4v ~= 1, 2);

    % 조건을 만족하는 행에 대해서만 각 행에 대해 다른 randn행을 더하기(by 행렬연산)
    randn_mat = randn(sum(condition), 2) * (1/n) * (1/m) * (1/2); %size는 내 기준 적당히 작은것 선택
    c4v(condition, :) = c4v(condition, :) + randn_mat;
    %}
end