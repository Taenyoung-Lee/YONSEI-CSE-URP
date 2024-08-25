function integ = GQIntegral2D_n(f, v1, v2, v3, v4, n, nGQ)
    % Initialize integral sum
    integral_sum = 0;

    % Divide the domain into n x n meshes
    %repmat, linspace 사용

    x_values = linspace(v1(1), v2(1), n+1);
    y_values = linspace(v1(2), v4(2), n+1);
            
    x_mesh = repmat(x_values', [1, n+1]);
    y_mesh = repmat(y_values, [n+1, 1]);
    for i = 1:n
        for j = 1:n
            % Calculate the vertices of the current mesh 근데 이 방법은 큰 도메인이 정사각형
            % 앞에서 짜왔던 mesh를 나누는 기법을 고민중
            % x_values = linspace(v1(1), v2(1), n+1);
            % y_values = linspace(v1(2), v4(2), n+1);
            % v1_mesh = [x_values(j), y_values(i)];   
            % v2_mesh = [x_values(j+1), y_values(i)];
            % v3_mesh = [x_values(j+1), y_values(i+1)];
            % v4_mesh = [x_values(j), y_values(i+1)];
            
            % %repmat, linspace 사용 => loop 밖으로 빼냄
            % 
            % x_values = linspace(v1(1), v2(1), n+1);
            % y_values = linspace(v1(2), v4(2), n+1);
            % 
            % x_mesh = repmat(x_values', [1, n+1]);
            % y_mesh = repmat(y_values, [n+1, 1]);
            % 
            % Mesh 불러오기
            v1_mesh = [x_mesh(i, j), y_mesh(i, j)];
            v2_mesh = [x_mesh(i, j+1), y_mesh(i, j+1)];
            v3_mesh = [x_mesh(i+1, j+1), y_mesh(i+1, j+1)];
            v4_mesh = [x_mesh(i+1, j), y_mesh(i+1, j)];

            % Calculate the integral for the current mesh using GQIntegral2D
            integral_mesh = GQintegral2D(f, v1_mesh, v2_mesh, v3_mesh, v4_mesh, nGQ);

            % Add the integral of the current mesh to the total integral sum
            integral_sum = integral_sum + integral_mesh;

        end
    end

    % Return the total integral sum
    integ = integral_sum;
end
