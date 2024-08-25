clc;
clear;
close all;

% triangle mesh 생성하기
m = 18; %세로 element 갯수
n = 18; %가로 element 갯수

% domain 범위 설정
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];

[v4e, c4v] = triangle2dmesh_domain(m, n, v1, v2, v3, v4);


% l2_projection_2d 
% f = @(x,y) (exp(x).*sin((pi)*y));
f = @(x,y) (sin((pi)*x).*sin((pi)*y));


M = local_M_2_M(v4e, c4v);
b = local_b_2_b(v4e, c4v, f);
Pf = M\b;

% Pf 시각화
figure;
c4v_t = c4v';
trisurf(v4e', c4v_t(1, :), c4v_t(2, :), Pf, 'FaceAlpha', 0.9);
title('L2 Projection of the given function f(x, y)');
xlabel('x');
ylabel('y');
zlabel('Function Value');
colorbar;


% % 원래 함수 시각화
% [X, Y] = meshgrid(linspace(0, 1, 100), linspace(0, 1, 100)); % 더 많은 점 생성하여 부드러운 플롯을 얻음
% F_original = f(X, Y); % 원래 함수 값 계산


% local_Matrix, Matrix 생성, 여기서 부터 function으로 묶기

function M = local_M_2_M(v4e, c4v)
    
    % fem2d_l2projection.pdf page 8
    c4v_t = c4v';
    node_count = size(c4v_t,2); % p 
    element_count = size(v4e,2); % t
    
    M = sparse(node_count,node_count);
    
    
    for k = 1:element_count
        loc2glb = v4e(1:3,k);
        x = c4v_t(1,loc2glb);
        y = c4v_t(2,loc2glb);
        
        % plot(x,y);
        % axis equal; %c4v, v4e가 올바르게 작동하는지 확인하기 위한 부분
    
        area = polyarea(x,y);
        M_k = [2 1 1; 1 2 1; 1 1 2;]/12*area; %local Mass Matrix
    
        M(loc2glb,loc2glb) = M(loc2glb, loc2glb) + M_k;
    
    end
end

   

% local_load_vector, load_vector 생성, 여기서 부터 function으로 묶기

function b = local_b_2_b(v4e, c4v, f)
    c4v_t = c4v';
    node_count = size(c4v_t,2); % p 
    element_count = size(v4e,2); % t
    b = zeros(node_count,1);

    for k = 1:element_count
        loc2glb = v4e(1:3, k);
        x = c4v_t(1, loc2glb);
        y = c4v_t(2, loc2glb);
        area = polyarea(x,y);
        b_k = [f(x(1),y(1)); f(x(2), y(2)); f(x(3), y(3))]/3*area;

        b(loc2glb) = b(loc2glb) + b_k;
    end
end




