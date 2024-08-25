clc;
clear;
close all;

% triangle mesh 생성하기
m = 16; % 세로 element 갯수
n = 16; % 가로 element 갯수


% domain 범위 설정
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];

[v4e, c4v] = triangle2dmesh_domain_in(m, n, v1, v2, v3, v4);

% l2_projection_2d 
f = @(x,y) sin(pi*x).*sin(pi*y);

% M = local_M_2_M(v4e, c4v);

area = 1/(2*m*n);
M_k = [2 1 1; 1 2 1; 1 1 2] / 12 * area;
M_k(:);
M = sparse(repmat(v4e, 3, 1), repelem(v4e, 3, 1), repmat(M_k(:), 1 ,size(repelem(v4e, 3, 1),2) ));

% b = local_b_2_b(v4e, c4v, f);

x4e = c4v(v4e,1);
y4e = c4v(v4e,2);
b_k = f(x4e,y4e) / 3 * area;
b = accumarray(v4e(:), b_k);


Pf = M\b;

% Pf 시각화
figure;
trisurf(v4e', c4v(:,1), c4v(:,2), Pf, 'FaceAlpha', 0.9);
title('L2 Projection of the given function f(x, y)');
xlabel('x');
ylabel('y');
zlabel('Function Value');
colorbar;




% area = 1/(2*m*n);
% M_k = [2 1 1; 1 2 1; 1 1 2] / 12 * area;
% M_k(:);
% M = sparse(repmat(v4e, 3, 1), repelem(v4e, 3, 1), repmat(M_k(:), 1 ,size(repelem(v4e, 3, 1),2) ));
% local_Matrix, Matrix 생성, 여기서 부터 function으로 묶기
% function M = local_M_2_M(v4e, c4v)
%     node_count = size(c4v, 1); % 노드 수 
%     element_count = size(v4e, 2); % 요소 수
% 
%     M = sparse(node_count,node_count);
% 
%     for k = 1:element_count
%         loc2glb = v4e(:, k);
%         x = c4v(loc2glb, 1);
%         y = c4v(loc2glb, 2);
% 
%         area = polyarea(x, y);
%         M_k = [2 1 1; 1 2 1; 1 1 2] / 12 * area; % local Mass Matrix
% 
%         M(loc2glb, loc2glb) = M(loc2glb, loc2glb) + M_k;
%     end
% end

% area = 1/(2*m*n);
% b_k = [f(x(1), y(1)); f(x(2), y(2)); f(x(3), y(3))] / 3 * area;
% repmat(v4e, 3, 1), repelem(v4e, 3, 1)
% load_vector = accumarray(v4e, local_load_vector(:), [n, 1]);
% 
% x4e = c4v(v4e,1);
% y4e = c4v(v4e,2);
% b_k = f(x4e,y4e) / 3 * area;
% b = accumarray(v4e(:), b_k);

% local_load_vector, load_vector 생성, 여기서 부터 function으로 묶기
% function b = local_b_2_b(v4e, c4v, f)
%     node_count = size(c4v, 1); % 노드 수 
%     element_count = size(v4e, 2); % 요소 수 
%     b = zeros(node_count, 1);
% 
%     for k = 1:element_count
%         loc2glb = v4e(:, k);
%         x = c4v(loc2glb, 1);
%         y = c4v(loc2glb, 2);
%         area = polyarea(x, y);
%         b_k = [f(x(1), y(1)); f(x(2), y(2)); f(x(3), y(3))] / 3 * area;
% 
%         b(loc2glb) = b(loc2glb) + b_k;
%     end
% end
