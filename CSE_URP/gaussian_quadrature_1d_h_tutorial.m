
clc;
clear;
close all;
format long;

%적분구간을 나누는(h) GQ


% Gaussian Quadrature 1D with h

% 조건
a = 0;
b = 1;
f = @(x) sin(pi * x);
true_value = 2/pi 

% 변환조건
% nGQ = 4;
% h = 2;

%그래프 플로팅
% 변화시키고 싶은 값들 설정
nGQ_values = 2:6;  % nGQ 값의 변화를 확인하기 위한 값들
h_values = 2:6;   % h 값의 변화를 확인하기 위한 값들

% Plot for nGQ 변화
figure;
hold on;
xlabel('nGQ');
ylabel('Approximate Integral Value (log scale)');
set(gca, 'YScale', 'log');  % y축을 log scale로 설정

for h = h_values
    values = zeros(size(nGQ_values));
    for i = 1:length(nGQ_values)
        values(i) = GQintegral1D(f, a, b, nGQ_values(i), h);
    end
    semilogy(nGQ_values, values, '-o', 'DisplayName', ['h = ', num2str(h)]);
end

semilogy(nGQ_values, true_value * ones(size(nGQ_values)), '--k', 'DisplayName', 'True Value');
legend;
hold off;

% Plot for h 변화
figure;
hold on;
xlabel('h');
ylabel('Approximate Integral Value (log scale)');
set(gca, 'YScale', 'log');  % y축을 log scale로 설정

for nGQ = nGQ_values
    values = zeros(size(h_values));
    for i = 1:length(h_values)
        values(i) = GQintegral1D(f, a, b, nGQ, h_values(i));
    end
    semilogy(h_values, values, '-o', 'DisplayName', ['nGQ = ', num2str(nGQ)]);
end

semilogy(h_values, true_value * ones(size(h_values)), '--k', 'DisplayName', 'True Value');
legend;
hold off;


% Gaussian Quadrature Calculate
GQintegral1D(f,a,b,nGQ,h)


function approximate = GQintegral1D(f,a,b,nGQ,h) % f is function; a,b is bound; nGQ determine points & weights, function 자체로 저장해놓기

interval = linspace(a,b,h);

[points, weights] = GQref1D(nGQ);

%GQ를 계산하는 부분
interval = linspace(a,b,h+2);

%for문을 활용하여 적분범위 앞에서 부터 순차계산

approximate = 0;
for i = 1:length(interval)-1

    approx_values = ( (interval(i+1)-interval(i))/2 ) * sum(weights .* f( ( (interval(i+1) - interval(i)) / 2 * points ) + ( (interval(i) + interval(i+1)) / 2) ) );
    approximate = approximate + approx_values;

end

end