clc;
clear;
close all;
% 기저 함수 개수
n = 3;

% x 값 범위 설정

x = linspace(0, 1, n);
h = x(2) - x(1);
% 기저 함수 생성
basis_functions = zeros(length(x), n);
for i = 1:n
    % 각 구간에서의 hat 함수를 사용하여 기저 함수 생성
    a = max(0, 1 - 2 * abs(x - x(i)) / h);
    plot(x,a,  'LineWidth', 1);hold on;
end

% 기저 함수 플롯
% 
% plot(x,a,  'LineWidth', 1);hold on;
% xlabel('x');
% ylabel('phi_i(x)');
% title('Basis functions using hat functions');
% legend('i=1', 'i=2', 'i=3', 'Location', 'best');
% grid on;
% hold off;
