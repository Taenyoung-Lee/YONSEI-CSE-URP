clc;
clear;
close all;
format long;

% Define initial value
nGQ = 3;
n = 2;


% Define your function f here
% f = @(x,y) (exp(x).*sin((pi)*y));
f = @(x,y) (sin((pi)*x).*sin((pi)*y));

% Define True value
% true_value = (exp(1)-1)*2/pi; % 2(e-1)/pi

true_value = integral2(f,0,1,0,1); % 2(e-1)/pi

% Define the vertices (v1, v2, v3, v4)   
v1=[0,0];
v2=[1,0];
v3=[1,1];
v4=[0,1];

% Define the range of values for n and nGQ
n_values = [1, 2, 4, 8, 16, 32, 64];
nGQ_values = [1, 2, 3, 4, 5];

% Initialize arrays to store errors
errors_n = zeros(size(n_values));
errors_nGQ = zeros(size(nGQ_values));




% Calculate errors for different n values
for i = 1:length(n_values)
    integral_approx = GQIntegral2D_n(f, v1, v2, v3, v4, n_values(i), nGQ);
    
    error = abs(integral_approx - true_value);
    errors_n(i) = error;
end

% % Calculate errors for different nGQ values
% for j = 1:length(nGQ_values)
%     integral_approx = GQIntegral2D_n(f, v1, v2, v3, v4, n, nGQ_values(j));
% 
%     error = abs(integral_approx - true_value);
%     errors_nGQ(j) = error;
% end

% Plotting


% Plot for n
figure;

loglog(n_values, errors_n, '-o');
xlabel('n');
ylabel('Error');
title('Error for n');


% % Plot for nGQ
% figure;
% 
% semilogy(nGQ_values, errors_nGQ, '-o');
% xlabel('nGQ');
% ylabel('Error');
% title('Error for nGQ');

rate = -(log(errors_n(2:end) ) - log(errors_n(1:end-1))) / log(2);
disp(rate)
