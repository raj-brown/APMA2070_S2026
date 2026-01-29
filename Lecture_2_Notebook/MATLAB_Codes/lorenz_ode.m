function lorenz_ode
    % Parameters
    sigma = 10;
    rho = 28;
    beta = 8/3;
    
    % Initial conditions
    initial_conditions = [1; 1; 1]; % [x0, y0, z0]
    
    % Time span for the simulation
    tspan = [0 25]; % From t=0 to t=25
    
    % Solve the ODE
    [~, Y] = ode45(@(t, Y) rhs(t, Y, sigma, rho, beta)...
        , tspan, initial_conditions);
    
    % Plotting the results
    figure;
    plot3(Y(:, 1), Y(:, 2), Y(:, 3), 'b-', LineWidth=2.0);
    title('Lorenz Attractor');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    axis equal;
end

function dYdt = rhs(t, Y, sigma, rho, beta)
    % Unpack the state variables
    x = Y(1);
    y = Y(2);
    z = Y(3);
    
    % Lorenz equations
    dxdt = sigma * (y - x);
    dydt = x * (rho - z) - y;
    dzdt = x * y - beta * z;
    
    % Pack the derivatives into a column vector
    dYdt = [dxdt; dydt; dzdt];
end
