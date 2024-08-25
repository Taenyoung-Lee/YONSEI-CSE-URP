clc;
clear;
close all;

% 주어진 함수 정의
% f = @(x) sin(pi.*x); % 수정: 주어진 함수로 변경
f = @(x) (2*x).*sin(2*pi * x) + 3;


% error 값 생성

% n_values = [4, 8, 16, 32, 64]; % n 값을 다양하게 설정
n_values = arrayfun(@(i) 2^i, 2:8);
error_values = zeros(size(n_values));

for k = 1:length(n_values)
    n = n_values(k); % 행 및 열의 개수
    x_intervals = linspace(0, 1, n);

    % Projection 계산
    projected_function = l2_projection_1D_tri(x_intervals, f);
    % (projected_function(i+1) - projected_function(i) ) / (x_intervals(2) - x_intervals(1)) * (x - x_intervals(i)) + projected_function(i)

    % error 계산
    error = 0;
    for i = 1:n-1
        exact_integral = integral(@(x) (f(x) - ( ( (projected_function(i+1) - projected_function(i) ) ./ (x_intervals(2) - x_intervals(1)) )  .* (x - x_intervals(i)) + projected_function(i) ) ).^2  , x_intervals(i), x_intervals(i + 1)); % 두 함수의 차의 절댓값을 적분하여 에러를 계산, <l2 norm>
        % exact_integral = integral(@(x) abs(f(x) - ( (
        % (projected_function(i+1) - projected_function(i) ) ./
        % (x_intervals(2) - x_intervals(1)) )  .* (x - x_intervals(i)) +
        % projected_function(i) ) )  , x_intervals(i), x_intervals(i + 1));
        % l1norm
        error = error + exact_integral; % 에러를 누적
    end
    error_values(k) = sqrt(error); % 누적된 에러를 저장

    % 결과 플롯
    x_values = linspace(0, 1, 1000); % 더 많은 점으로 그래프를 그리기 위해
    figure;
    plot(x_values, f(x_values), 'b', 'LineWidth', 2); hold on;
    plot(x_intervals, projected_function, '-o', 'LineWidth', 2);
    legend('Original Function', 'Projected Function', 'Location', 'best');
    xlabel('x');
    ylabel('f(x)');
    title(['Projection and Original of function, n = ', num2str(n)]);
    grid on;
    hold off;
end

% error plot
figure;
loglog(n_values, error_values, '-o', 'LineWidth', 2);
xlabel('n');
ylabel('Error');
title('Convergence Error');
grid on;

% error rate
rate = -(log(error_values(2:end)) - log(error_values(1:end-1))) ./ log(2); 
disp('error rate');
disp(rate);

%%% Projection 함수 정의
function [projected_function] = l2_projection_1D_tri(x_intervals, f)
    n = length(x_intervals);
    h = x_intervals(2) - x_intervals(1);

    % n4e 매트릭스 생성
  
    
    n4e = zeros(2, n-1);
    for i = 1:n-1
        n4e(:, i) = [i; i+1];
    end
    


    % local load vector 계산 -> basis순서로 돌리지 말고, element넘버로 for문
    local_load_vector = zeros(2,n-1); %2 x (# of element)
    for i = 1 : n-1
        local_load_vector(2,i) = GQIntegral1D(@(x) (f(x) .* (1/h) .* (x - x_intervals(i))  ) , x_intervals(i), x_intervals(i+1) , 3, 100);
        local_load_vector(1,i) = GQIntegral1D(@(x) (f(x) .* (-1/h) .* (x - x_intervals(i+1)) ) , x_intervals(i), x_intervals(i+1) , 3, 100);
    end
    
    % load_vector 계산
    
    load_vector = accumarray(n4e(:), local_load_vector(:), [n, 1]);



    % local_M 행렬 생성
    local_M = [h/3, h/6; h/6, h/3];
    % % M_matrix
    % M = sparse(n, n);
    % for i = 1:n-1
    %     M(i:i+1, i:i+1) = M(i:i+1, i:i+1) + local_M;
    % end

    % local_M 행렬을 확장하여 전체 M 행렬을 구성 -> sparse를 만들고 바꾸지 말고, 한번에 생성
    M = sparse(repmat(n4e, 2, 1), repelem(n4e, 2, 1), repmat(local_M(:), 1, n-1));


    x_solution = M \ load_vector;
    projected_function =  x_solution;
end


