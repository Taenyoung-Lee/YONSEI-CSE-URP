function [points, weights] = GQref1D(nGQ) %점과 가중치를 반환, point순서대로 정렬해서 weight도 맞춰서 쓰기    
switch nGQ
    case 1
        weights = 2;
        points = 0;
    case 2
        weights = [1,1];
        points = [-0.5773502691896257,	0.5773502691896257];
    case 3
        weights = [0.8888888888888888, 0.5555555555555556, 0.5555555555555556];
        points = [0, -0.7745966692414834, 0.7745966692414834];
    case 4
        weights = [0.6521451548625461, 0.6521451548625461, 0.3478548451374538, 0.3478548451374538];
        points = [-0.3399810435848563, 0.3399810435848563, -0.8611363115940526, 0.8611363115940526];
    case 5
        weights = [0.5688888888888889, 0.4786286704993665, 0.4786286704993665, 0.2369268850561891, 0.2369268850561891];
        points = [0, -0.5384693101056831, 0.5384693101056831, -0.9061798459386640, 0.9061798459386640];
    case 6
        weights = [0.360761573, 0.360761573, 0.467913935, 0.467913935, 0.171324492, 0.171324492];
        points = [0.661209386,-0.661209386, -0.238619186, 0.238619186, -0.932469514, 0.932469514];
    case 7 
        weights = [0.417959184, 0.381830051, 0.381830051, 0.279705391, 0.279705391, 0.129484966, 0.129484966];
        points = [0, 0.405845151, -0.405845151, -0.741531186, 0.741531186, -0.949107912, 0.949107912];
    otherwise
        error("not defined case");
end
end