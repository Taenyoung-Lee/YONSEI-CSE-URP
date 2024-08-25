%%% Projection 함수 정의
function [projected_function] = l2_projection_1D(x, f)
    n = length(x);
    h = x(2) - x(1);
    

    % loadVector를 계산(GQ).
    loadVector = zeros(n, 1); 
    for i = 1:n-1
        
        nGQ = 4; % 가우스 적분의 점의 개수
        approx_values = GQIntegral1D(f, x(i), x(i+1), nGQ, 10);
        loadVector(i) = loadVector(i) + approx_values/2;
        loadVector(i + 1) = loadVector(i + 1) + approx_values/2;
    end


    % local_M 행렬 생성
    local_M = [h/3, h/6; h/6, h/3];
    % M_matrix
    M = sparse(n, n);
    for i = 1:n-1
        M(i:i+1, i:i+1) = M(i:i+1, i:i+1) + local_M;
    end

    x_solution = M \ loadVector;
    projected_function =  x_solution;
end