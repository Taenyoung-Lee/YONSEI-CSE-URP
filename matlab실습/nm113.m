%nm113.m
f = input('Input the temperature in Fahrenheit[F]:');
c = 5/9*(f-32);
fprintf('%5.2f(in Fahrenheit) is %5.2f(in Centigrade).\n',f,c)
fid=fopen('nm113.dat', 'w');
fprintf(fid, '%5.2f(Fahrenheit) is %5.2f(Centigrade).\n',f,c);
fclose(fid);