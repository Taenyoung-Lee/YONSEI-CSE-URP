%nm119_5: example of switch-case-end block
point = 85;
switch floor(point/10) %floor(x): integer less than or equal to x
case 9, grade = 'A'
case 8, grade = 'B'
case 7, grade = 'C'
case 6, grade = 'D'
otherwise grade = 'F'
end