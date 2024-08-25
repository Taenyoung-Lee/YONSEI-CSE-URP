clc;
clear;
close all;

% 구간 설정 [x_initi,x_end]
x_initi = 0;
x_end = 1;

num_element = 16; %element 개수를 기준으로 세운다.
n = num_element-1; % 행 및 열의 개수

x = linspace(x_initi, x_end, n);

h = x(2) - x(1); % 간격 계산

% 주어진 함수 정의
% f = @(x) (2*x).*sin(pi * x) + 3 ;
f = @(x) sin(pi*x);

% Load vector 계산 accumarray(n4e,local_b)
b = zeros(n, 1);
for i = 1:n
    b(i) = trapz(x, f(x) .* max(0, 1 - 2 * ( abs(x - x(i)) ) / h));
end

% M 매트릭스 초기화
M = zeros(n, n);

% M 매트릭스 계산
for i = 1:n
    % M_{i,i}
    if i > 1 && i < n
        M(i, i) = (x(i+1) - x(i-1)) / 3;
    elseif i == 1 || i == n
        M(i, i) = (x(2) - x(1)) / 3;
    end
    
    % M_{i,i+1}
    if i < n
        M(i, i+1) = (x(i+1) - x(i)) / 6;
    end
    
    % M_{i,i-1}
    if i > 1
        M(i, i-1) = (x(i) - x(i-1)) / 6;
    end
end

% 선형 시스템 해결
x_solution = M \ b;

% 햇 함수 계산
hat_functions = zeros(n, n);
for i = 1:n
    hat_functions(:, i) = max(0, 1 - 2 * abs(x - x(i)) / h);
end

% 프로젝션된 함수 계산
projected_function = hat_functions * x_solution; %pf

% 결과 플롯
x_values = linspace(x_initi, x_end, 1000); % 더 많은 점으로 그래프를 그리기 위해
figure;
plot(x_values, f(x_values), 'b', 'LineWidth', 2);
hold on;
plot(x, projected_function, 'r--', 'LineWidth', 2);
plot(x, projected_function, 'ro', 'MarkerSize', 5); % projected function의 포인트에 점 찍기
plot(x, f(x), 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b'); % 원래 함수의 포인트에 점 찍기
legend('Original Function', 'Projected Function', 'Projected Points', 'Original Points', 'Location', 'best');
xlabel('x');
ylabel('f(x)');
title('Projection of sin(\pi x)');
grid on;
hold off;
