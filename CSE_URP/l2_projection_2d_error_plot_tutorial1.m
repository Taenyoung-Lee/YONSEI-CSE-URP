clc;
clear;
close all;

% n 값 범위 설정
n_values = 2.^(1:8); %2의 몇 제곱까지 증가할 것인지 결정 (여기서는 2^8까지)

% 각 n 값에 따른 총 오차 계산
total_errors = zeros(size(n_values));

for idx = 1:numel(n_values)
    n = n_values(idx);
    
    % triangle mesh 생성하기
    m = n; % 세로 element 갯수

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
    total_errors(idx) = total_error;
end

% 결과 플롯
figure;
loglog(n_values, total_errors, '-o', 'LineWidth', 2);
title('Total Error vs. Number of Elements (n)');
xlabel('Number of Elements (n)');
ylabel('Total Error');
grid on;

% error rate 계산 및 출력
error_rate = -(log(total_errors(2:end)) - log(total_errors(1:end-1))) ./ log(2);
disp('Error rate:');
disp(error_rate);


% 행렬식으로 입체도형의 부피 구하는 함수 부피로 구하는게 아니라 Pf 세점으로 평면을 구해서 f평면 - Pf평면으로 계산

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
    volume = abs(1/2 * ((x2 - x1) * (y3 - y1) * (Pf2 - Pf1) + (x3 - x1) * (y2 - y1) * (Pf3 - Pf1)));
end
% % function volume = compute_volume(vertices)
% %     % 세 점의 좌표
% %     A = vertices(1,:);
% %     B = vertices(2,:);
% %     C = vertices(3,:);
% % 
% %     % AB, AC 벡터
% %     AB = B - A;
% %     AC = C - A;
% % 
% %     % 외적 계산
% %     cross_product = cross(AB, AC);
% % 
% %     % 부피 계산 (절댓값 취함)
% %     volume = abs(dot(A, cross_product)) / 6;
% % end
