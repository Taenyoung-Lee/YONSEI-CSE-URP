clc; clear; close all;

%구간 정리
a = 0;
b = 1;

% x 값 생성
num_element = 10; 
n = num_element - 1; % 행 및 열의 개수, n-1 => 나눠진 구간의 개수
x = linspace(a, b, n); % Lecture note (10.24)

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

% 결과 출력
disp('M 매트릭스:');
disp(M);


