clc;
clear;
close all;
format long;

% F =@(x,y) (sin((pi)*x).*sin((pi)*y));
% F = @ (x, y) (x.^2).*sin(pi*y);
F = @(x,y) 1/(2*pi) * exp( -1/2 * (x.^2 + y.^2));
% v1=[-1,-1];
% v2=[1,-1];
% v3=[1,1];
% v4=[-1,1];
% 
v1=[-5,-5];
v2=[5,-5];
v3=[5,5];
v4=[-5,5];




% Mesh를 나눠서 적분한 결과를 출력하고 시각화
n = 100; % Mesh 수
nGQ = 5; % Gaussian Quadrature 점의 개수
fprintf('Mesh Division Integral: %.6f\n', GQIntegral2D_n(F, v1, v2, v3, v4, n, nGQ));

% 시각화
figure;
hold on;

% 원래 함수를 그리기 위한 코드
x = linspace(-1, 1, 50);
y = linspace(-1, 1, 50);
[X, Y] = meshgrid(x, y);
Z = F(X, Y);
surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');



% Mesh를 그리기 위한 코드
for i = 1:n
    for j = 1:n
        % 각 Mesh의 네 꼭지점 계산
        x_values = linspace(v1(1), v2(1), n+1);
        y_values = linspace(v1(2), v4(2), n+1);
        v1_mesh = [x_values(j), y_values(i)];
        v2_mesh = [x_values(j+1), y_values(i)];
        v3_mesh = [x_values(j+1), y_values(i+1)];
        v4_mesh = [x_values(j), y_values(i+1)];

        % Mesh를 그림
        vertices_mesh = [v1_mesh; v2_mesh; v3_mesh; v4_mesh; v1_mesh];
        plot3(vertices_mesh(:, 1), vertices_mesh(:, 2), zeros(5, 1), 'r-');
    end
end

xlabel('x');
ylabel('y');
zlabel('z');
title('Mesh Division Visualization');
axis tight;
axis equal;
view(3);
hold off;

