% clc;
% clear;
% close all;
% 
% %2D rectangle fem mesh
% 
% [v4e, c4v] = trap2dmesh(4,3); % m by n; m이 가로
% disp('v4e');
% disp(v4e);
% disp('c4v');
% disp(c4v);
% 
% 
% %그림그리기
% 
% figure; 
% patch('Vertices', c4v, 'Faces', v4e', 'FaceColor', 'none', 'EdgeColor', 'b');
% axis equal;
% grid on;

% matrix만들기
function [v4e, c4v] = rectangle2dmesh(m, n)
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
end




