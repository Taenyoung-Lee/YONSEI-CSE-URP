function [points, weights] = GQref2Dtri(nGQ) %점과 가중치를 반환, point순서대로 정렬해서 weight도 맞춰서 쓰기    
switch nGQ
    case 1
        weights = 1/2;
        points = [1/3 1/3];
    case 2
        weights = [1/6 1/6 1/6]';
        points = [1/6 1/6 ; 2/3 1/6 ; 1/6 2/3];
    case 3
        weights = [-27/96 25/96 25/96 25/96]';
        points = [1/3 1/3 ; 1/5 1/5 ; 3/5 1/5 ; 1/5 3/5];

   otherwise
        error("not defined case");
end
end