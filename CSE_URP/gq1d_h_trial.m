clc;
clear;
close all;

a = 0;
b = 1;
h = 1;
nGQ = 3;
f = @(x) sin(pi .* x);
true_value = 2/pi;


[points, weights] = GQref1D(nGQ);
interval = linspace(a,b,h+2);

%for문을 활용하여 적분범위 앞에서 부터 순차계산

approximate = 0;
for i = 1:length(interval)-1

    approx_values = ( (interval(i+1)-interval(i))/2 ) * sum(weights .* f( ( (interval(i+1) - interval(i)) / 2 * points ) + ( (interval(i) + interval(i+1)) / 2) ) );
    approximate = approximate + approx_values;

end


% %벡터화(실패)
% 
% x_pluspart = (interval(1:end-1) + interval(2:end)) / 2;
% x_minuspart = (interval(2:end) - interval(1:end-1)) / 2;
% 
% result = sum(x_minuspart .* sum(weights .* f(x_minuspart' * points+ x_pluspart)));
