
clc;
clear;
close all;
format long;




% Gaussian Quadrature 1D with h

% 조건
a = 0;
b = 1;
f = @(x) sin(pi * x);
true_value = 2/pi; 

% 변환조건
% nGQ = 4;
% h = 2; h는 구간을 1/(2^h) 로 나눈다.

%그래프 플로팅
% 변화시키고 싶은 값들 설정
nGQ_values = 1:5;  % nGQ 값의 변화를 확인하기 위한 값들

n_values = 1:8;   % h 값의 변화를 확인하기 위한 값들

% Plot for nGQ 변화
figure;
hold on;
xlabel('nGQ');
ylabel('Approximate Integral Value (log scale)');
set(gca, 'YScale', 'log');  % y축을 log scale로 설정

for n = n_values
    values = zeros(size(nGQ_values));
    errors = zeros(size(nGQ_values));
    for i = 1:length(nGQ_values)
        values(i) = GQintegral1D(f, a, b, nGQ_values(i), 2^n);
        errors(i) = abs(true_value - values(i));
    end
    %semilogy(nGQ_values, values, '-o', 'DisplayName', ['h = ', num2str(h)]);
    semilogy(nGQ_values, errors, '--x', 'DisplayName', ['Error, h = ', num2str(n)]);
end

semilogy(nGQ_values, true_value * ones(size(nGQ_values)), '--k', 'DisplayName', 'True Value');
legend;
hold off;

% Plot for n 변화
figure;
hold on;
xlabel('h');
ylabel('Approximate Integral Value (log scale)');
set(gca, 'XScale','log','YScale', 'log');  % y축을 log scale로 설정

for nGQ = nGQ_values
    values = zeros(size(n_values));
    errors = zeros(size(n_values));
    for i = 1:length(n_values)
        values(i) = GQintegral1D(f, a, b, nGQ, 2^n_values(i));
        errors(i) = abs(true_value - values(i));
    end
    %semilogy(h_values, values, '-o', 'DisplayName', ['nGQ = ', num2str(nGQ)]);
    loglog(2.^n_values, errors, '--x', 'DisplayName', ['Error, nGQ = ', num2str(nGQ)]);
end

loglog(2.^n_values, true_value * ones(size(n_values)), '--k', 'DisplayName', 'True Value');
legend;
hold off;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%위는 plot, 아래는 함수 define


% Gaussian Quadrature Calculate
GQintegral1D(f,a,b,nGQ,n)


function approximate = GQintegral1D(f,a,b,nGQ,n) % f is function; a,b is bound;

[points, weights] = GQref1D(nGQ);

%GQ를 계산하는 부분
interval = linspace(a,b,n+2);

%for문을 활용하여 적분범위 앞에서 부터 순차계산

approximate = 0;
for i = 1:length(interval)-1

    approx_values = ( (interval(i+1)-interval(i))/2 ) * sum(weights .* f( ( (interval(i+1) - interval(i)) / 2 * points ) + ( (interval(i) + interval(i+1)) / 2) ) );
    approximate = approximate + approx_values;

end

end