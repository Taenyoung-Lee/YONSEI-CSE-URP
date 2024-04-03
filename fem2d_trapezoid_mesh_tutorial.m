clc;
clear;
close all;

%2D trapezoidal fem mesh

%focus : n이 odd인지 even인지 고려, x방향 변화만 고려, 변화량이 모두 같게 설정
%{
m = randi([3,10]);
n = randi([3,10]);
%}
[c4v,v4e] = trapz2dmesh(4,4); % m by n; m이 가로
disp('v4e');
disp(v4e);
disp('c4v');
disp(c4v);


%그림그리기

figure; 
patch('Vertices', c4v, 'Faces', v4e', 'FaceColor', 'none', 'EdgeColor', 'b');
axis equal;
grid on;

% matrix만들기
function [c4v,v4e] = trapz2dmesh(m, n)
    %v4e matrix 생성
    mat = reshape(1:(m+1)*(n+1),m+1,n+1);
    v = mat(1:end-1, 1:end-1);
    v4e = v(:)';  % reshape v into a column vector and transpose
    v4e = [v4e; v4e(1,:) + 1; v4e(1,:) + m+1 + 1; v4e(1,:) + m+1];



    %c4v matrix 생성

    %trapezoide 형식으로 약간의 변형을 주어야함
    a = linspace(0,1,m+1);
    %a1 = repmat(a',m,1);


    %여기서 한 element의 가로 길이는 1/m 이하 이므로, t(좌우변화폭)은 t<(1/m)
    t = randn;% 정규분포를 활용하여 -1~1사이 값을 추출, 유니폼분포를 사용(uiform 많이 생성해서 평균값을 쓰는 방법)
    while abs(t) >= 1/m % while, t 안쓰고 randn*(1/m)방식도 가능
        t = randn;
    end

    %n이 odd number라면, 
    a2 = a;
    a2(:,2:end-1) = a(:,2:end-1) + t; 
    
    col1 = reshape([a,a2],[],1);
    col1 = repmat(col1,floor((n+1)/2),1); % floor을 사용하여 임의의 n에 대해서도 동작.
    if mod(n,2) == 0 % n이 even number인 경우, append보다는 전체 matric에서 없애는 방향으로
        col1 = [col1;a']; %변수반복사용 차라리 temp등을 활용

    end

    aa = linspace(0,1,n+1); %세로값의 변화는 가정한 trapezoidal에서 없다.
    aa1 = repelem(aa',length(a),1); %세로값의 변화는 가정한 trapezoidal에서 없다.

    c4v = [col1,aa1];
end