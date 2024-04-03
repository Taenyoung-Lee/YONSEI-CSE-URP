clc;
clear;
close all;

m = 4;
n = 3;

a = linspace(0,1,m+1);
aa = linspace(0,1,n+1);
a1 = repmat(a',m,1);
a2 = repelem(aa',m+1,1);

c4v = [a1,a2]