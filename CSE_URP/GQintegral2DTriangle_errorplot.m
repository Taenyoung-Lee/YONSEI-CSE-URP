clc;
clear;
close all;
format long;

% Define initial value
nGQ = 2;



% Define your function f here
f = @(x,y) (exp(x).*sin((pi)*y));
% f = @(x,y) (sin((pi)*x).*sin((pi)*y));
% f = @(x, y) (x >= 0) & (y >= 0) & (x + y <= 1);
% Define True value
 %true_value = (exp(1)-1)*2/pi; % 2(e-1)/pi

true_value = integral2(f,0,1,0,1);
% true_value = ;
% Define the vertices (v1, v2, v3, v4)   
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];

% Define the range of values for n and nGQ
% n_values = [1, 2, 4, 8, 16, 32, 64];
n_values = 2.^(0:8);
% n_values = [3];

% Initialize arrays to store errors
errors_n = zeros(size(n_values));




% Calculate errors for different n values
for i = 1:length(n_values)
    integral_approx = GQintegral2DTriangle_n(f, v1, v2, v3, v4, n_values(i), nGQ);
    
    error = abs(integral_approx - true_value);
    errors_n(i) = error;
    % disp(length(error));
    % disp(length(errors_n));
end



% Plotting


% Plot for n
figure;
set(gca, 'YScale', 'log')
loglog(n_values, errors_n, '-o');
xlabel('n');
ylabel('Error');
title('Error for n');




rate = -(log(errors_n(2:end) ) - log(errors_n(1:end-1))) / log(2);
disp(rate)

