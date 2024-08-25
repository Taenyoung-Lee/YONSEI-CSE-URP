clc;
clear;
close all;

% triangle mesh 생성하기
m = 20; % 세로 element 갯수
n = m; % 가로 element 갯수


% domain 범위 설정
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];

[v4e, c4v] = triangle2dmesh_domain(m, n, v1, v2, v3, v4);

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


% 각 요소의 부피를 저장할 변수 초기화
element_volumes = zeros(size(v4e, 2), 1);
integration_errors = zeros(size(v4e, 2), 1);

% 각 요소에 대한 부피 계산 및 적분 값 계산
for i = 1:size(v4e, 2)
    % 현재 요소의 꼭지점 좌표
    vertices = c4v(v4e(:, i), :);
    
    
    % 부피 계산
    element_volumes(i) = compute_volume(vertices, Pf(v4e(:, i)));
    
    % 적분 값 계산
    integral_value = integral2(f, vertices(1,1), vertices(3,1), vertices(1,2), vertices(3,2));
    
    % 에러 계산
    integration_errors(i) = abs(integral_value - element_volumes(i));
end

% 총 에러 계산
total_error = sum(integration_errors);



% 행렬식으로 입체도형의 부피 구하는 함수

function volume = compute_volume(vertices, Pf_values)
    % 각 꼭지점의 좌표와 Pf 값
    x1 = vertices(1, 1);
    y1 = vertices(1, 2);
    Pf1 = Pf_values(1);
    
    x2 = vertices(2, 1);
    y2 = vertices(2, 2);
    Pf2 = Pf_values(2);
    
    x3 = vertices(3, 1);
    y3 = vertices(3, 2);
    Pf3 = Pf_values(3);
    
    % 세 점과 밑면이 이루는 부피 계산 (행렬식)
    volume = abs(1/6 * ((x2 - x1) * (y3 - y1) * (Pf2 - Pf1) + (x3 - x1) * (y2 - y1) * (Pf3 - Pf1)));
end
