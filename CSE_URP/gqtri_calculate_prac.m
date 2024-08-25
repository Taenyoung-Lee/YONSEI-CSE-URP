%Calculate 결과 해석
clc;
clear;
close all;
format long;

% 적분할 함수 정의
f = @(x, y) sin(pi*x).*cos(pi*y);
% f = @(x, y) exp(x+y);


%삼각형의 정의점(1)
v1 = [0, 0];
v2 = [1, 0];
v3 = [1, 1];
v4 = [0, 1];

% Gauss 적분을 위한 점과 가중치 설정 (예: 2차 Gauss 적분)
nGQ =3;

%함수 호출하여 적분 실행
integral_value = GQintegral2D(f, v1, v2, v3, v4, nGQ);


% n = 3;
% new_integral_value = GQintegral2DTriangle_n(f, v1, v2, v3, v4, n, nGQ);

true_value =  1;
% 결과 출력
disp(['수치적분 결과: ', num2str(integral_value)]);
% disp(['수치적분 결과2: ', num2str(new_integral_value)]);
disp(['해석적분 결과: ', num2str(true_value)]);



