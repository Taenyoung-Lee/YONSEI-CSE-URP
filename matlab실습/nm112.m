%nm112.m
clear
A = [1 2 3;4 5 6]
B = [3;-2;1];
C(2) = 2; C(4) = 4
disp('Press any key to see the input/output through Files')
save ABCABC %save A,B & C as a MAT-file named ¡¯ABC.mat¡¯
clear('A','C') %remove the memory about A and C
load ABC A C %read MAT-file to recollect the memory about A and C
save B.dat B -ascii %save B as an ASCII-file named ¡¯b.dat¡¯
clear B
load b.dat %read ASCII-file to recollect the memory about b
b
x = input('Enter x:')
format short e
x
format rat, x
format long, x
format short, x