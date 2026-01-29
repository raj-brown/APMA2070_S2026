function poisson
    % Domain size
    L = 1; % length of the domain in both x and y directions
    N = 50; % number of grid points in each direction
    dx = L / (N + 1); % grid spacing
    dy = L / (N + 1); % grid spacing  
    % Create grid points
    x = linspace(0, L, N + 2);
    y = linspace(0, L, N + 2);
    % Initialize solution matrix
    u = zeros(N + 2, N + 2);
    % Source term
    f = 2 * ones(N, N); % f(x,y) = 2   
    % Boundary conditions (u = 0 on the boundary)
    % u is already initialized to 0, so no need to set boundaries explicitly.    
    % Iterative solver (Gauss-Seidel method)
    for iter = 1:10000
        u_old = u; % Store the old solution
        for i = 2:N+1
            for j = 2:N+1
                u(i, j) = 0.25 * (u_old(i+1, j) + u_old(i-1, j) + u_old(i, j+1) + u_old(i, j-1) - dx^2 * f(i-1, j-1));
            end
        end
        
        % Check for convergence
        if max(max(abs(u - u_old))) < 1e-6
            break;
        end
    end
     % Plot the result
    figure;
    surf(x, y, u);
    xlabel('x');
    ylabel('y');
    zlabel('u(x,y)');
    title('Solution to the Poisson Equation');
    shading interp; % Smooth shading
    colorbar; % Add color bar
end


