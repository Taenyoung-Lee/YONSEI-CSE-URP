clc;
clear;
close all;

% x 값 생성
n = 6; % 행 및 열의 개수
x = linspace(0, 1, n);
h = x(2) - x(1); % 간격 계산

% 주어진 함수 정의

% f = @(x) (sin(pi*x))
f = @(x) (2*x).*sin(2*pi * x) + 3 ;


% Load vector 계산
b = zeros(n, 1);
for i = 1:n
    b(i) = trapz(x, f(x) .* max(0, 1 - 2 * abs(x - x(i)) / h));
end

% % M 행렬 생성
M = zeros(n, n);
for i = 1:n
    for j = 1:n
        if i == j
            if i == 1 || i == n
                M(i, i) = h / 3;
            else
                M(i, i) = 2 * h / 3;
            end
        elseif abs(i - j) == 1
            M(i, j) = h / 6;
        end
    end
end



% 선형 시스템 해결 => '\' or Thomas algorithm(tridiagonal matrix algorithm)으로 해결
x_solution = M \ b;

% hat function 계산
hat_functions = zeros(n, n);
for i = 1:n
    hat_functions(:, i) = max(0, 1 - 2 * abs(x - x(i)) / h);
end

% 프로젝션된 함수 계산
projected_function = hat_functions * x_solution;

% 결과 플롯
x_values = linspace(0, 1, 1000); % 더 많은 점으로 그래프를 그리기 위해
figure;
plot(x_values, f(x_values), 'b', 'LineWidth', 2); hold on;
plot(x, projected_function, 'r--', 'LineWidth', 2);
legend('Original Function', 'Projected Function', 'Location', 'best');
xlabel('x');
ylabel('f(x)');
title('Projection of sin(\pi x)');
grid on;
hold off;
