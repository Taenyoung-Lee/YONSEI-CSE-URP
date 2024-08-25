clc;
clear;
close all;

% x 값 생성
n = 10; % 행 및 열의 개수
x = linspace(0, 1, n);

% 주어진 함수 정의
f = @(x) (2*x).*sin(2*pi * x) + 3 ;

% Load vector 계산
b = zeros(n, 1);
for i = 1:n
    % i가 1일 때
    if i == 1
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i+1) - x(i)));

    % i가 n일 때
    elseif i == n
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i) - x(i-1)));
        
    % i가 2에서 n-1 사이일 때
    else
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i+1) - x(i-1)));
    end

    % 주어진 함수와 기저 함수의 내적을 적분하여 로드 벡터 계산
    integrand = f(x) .* hat_function;
    b(i) = trapz(x, integrand);
end

% M 행렬 생성
M = zeros(n, n);
for i = 1:n
    % i가 1일 때
    if i == 1
        % M_{i,i}
        M(i, i) = (x(i+1) - x(i)) / 3;
        
        % M_{i,i+1}
        M(i, i+1) = (x(i+1) - x(i)) / 6;

    % i가 n일 때
    elseif i == n
        % M_{i,i}
        M(i, i) = (x(i) - x(i-1)) / 3;
        
        % M_{i,i-1}
        M(i, i-1) = (x(i) - x(i-1)) / 6;
        
    % i가 2에서 n-1 사이일 때
    else
        % M_{i,i}
        M(i, i) = (x(i+1) - x(i-1)) / 3;
        
        % M_{i,i+1}
        M(i, i+1) = (x(i+1) - x(i)) / 6;
        
        % M_{i,i-1}
        M(i, i-1) = (x(i) - x(i-1)) / 6;
    end
end

% 선형 시스템 해결
x_solution = M \ b;

% 프로젝션된 함수 계산
projected_function = zeros(size(x));
for i = 1:n
    % i가 1일 때
    if i == 1
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i+1) - x(i)));

    % i가 n일 때
    elseif i == n
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i) - x(i-1)));
        
    % i가 2에서 n-1 사이일 때
    else
        % i번째 hat function 정의
        hat_function = max(0, 1 - 2 * abs(x - x(i)) / (x(i+1) - x(i-1)));
    end
    
    projected_function = projected_function + x_solution(i) * hat_function;
end


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


