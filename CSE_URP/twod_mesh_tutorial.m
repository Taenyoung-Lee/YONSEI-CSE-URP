% 2D 노드 생성, 메쉬 생성 및 시각화
clear
% 임의의 2x5 매트릭스 생성 (노드의 x와 y 좌표)
nodes = rand(2, 5) * 10;  % 0에서 10 사이의 임의의 좌표

% Delaunay 삼각분할을 사용하여 2D 메쉬 생성???
tri_method = delaunay(nodes(1,:), nodes(2,:));

% 시각화
figure;
triplot(tri_method, nodes(1,:), nodes(2,:), 'b');
hold on;
plot(nodes(1,:), nodes(2,:), 'r*');  % 노드 표시
for i = 1:size(nodes, 2)
    text(nodes(1,i), nodes(2,i), ['P' num2str(i)], ...
         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
xlabel('X');
ylabel('Y');
title('2D Mesh with Delaunay Triangulation');
grid on;
hold off;
