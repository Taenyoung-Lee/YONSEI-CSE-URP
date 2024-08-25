% 1D 노드 생성, 메쉬 생성 및 시각화
clc;
clear;
close all;

% 길이와 노드 수 정의
length = 8;  % 길이
num_nodes = 17;    % 노드의 개수

% 빔을 따라 균일하게 분포된 노드의 위치 계산

x = linspace(0, length, num_nodes);
y = zeros(1, num_nodes);  % 1D 빔이므로 y 좌표는 모두 0

% 시각화
figure;
plot(x, y, 'bo-', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('X');
ylabel('Y');
title('1D Mesh');
axis([0 length -1 1]);
grid on;

% 각 노드 위치를 표시
for i = 1:num_nodes
    text(x(i), y(i), ['Node ' num2str(i)], ...
         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
