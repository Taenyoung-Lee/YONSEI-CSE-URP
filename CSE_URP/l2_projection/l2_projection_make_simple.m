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



% Load vector 계산 => 구간에 대해서 두개의 basis 만 가져와서 계산하는 방법
loadVector = zeros(n, 1);
for i = 1:n-1
    intervalLength = x(i + 1) - x(i); % Length of the current interval 
    loadVector(i) = loadVector(i) + 0.5 * intervalLength * f(x(i));
    loadVector(i + 1) = loadVector(i + 1) + 0.5 * intervalLength * f(x(i + 1));
end



% local_M 행렬 생성
local_M = [h/3, h/6; h/6, h/3];
% M 생성
M = sparse(n, n);
for i = 1:n-1
    M(i:i+1, i:i+1) = M(i:i+1, i:i+1) + local_M;
end






% 선형 시스템 해결 => '\' or Thomas algorithm(tridiagonal matrix algorithm)으로 해결
x_solution = M \ loadVector;

% 프로젝션된 함수 계산
projected_function =  x_solution;

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


