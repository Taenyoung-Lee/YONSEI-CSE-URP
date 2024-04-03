clc;
clear;
close all;

m = 3;
n = 3;

mat = reshape(1:(m+1)*(n+1),m+1,n+1);
v = mat(1:end-1, 1:end-1);
%{
v(:) %this is v4e matrix element startpoint

v4e = v(:)'
v4e(2,:) = v4e(1,:)+1;
v4e(3,:) = v4e(1,:)+(m+1)+1;
v4e(4,:) = v4e(1,:)+(m+1)+1-1;
v4e

%}
v4e = v(:)';  % Reshape v into a column vector and transpose
% %사각형인 경우
% v4e = [v4e; v4e(1,:) + 1; v4e(1,:) + m+1 + 1; v4e(1,:) + m+1];

% %삼각형인 경우
v4e = [v4e; v4e(1,:) + 1; v4e(1,:) + m+1];
v4e