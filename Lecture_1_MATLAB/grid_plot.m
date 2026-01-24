Nx = 32;             % Number of interior points in x
Ny = 32;             % Number of interior points in y

hx = 1/(Nx+1);       % Grid spacing in x
hy = 1/(Ny+1);       % Grid spacing in y

% Interior grid points
x = (1:Nx)*hx;
y = (1:Ny)*hy;
[X,Y] = meshgrid(x,y);

% Boundary grid points
xb = [0:hx:1, 0:hx:1, zeros(1,Ny), ones(1,Ny)];
yb = [zeros(1,Nx+2), ones(1,Nx+2), (1:Ny)*hy, (1:Ny)*hy];

% Plot
figure; hold on; box on;

% Interior points
scatter(X(:), Y(:), 25, 'b', 'filled');

% Boundary points
scatter(xb, yb, 40, 'r', 'filled');

% Formatting
axis equal;
axis([0 1 0 1]);
xlabel('x');
ylabel('y');
title('Grids: [32, 32] ');

legend('Interior points', 'Boundary points', 'Location', 'best');
set(gca, 'FontSize', 12);

hold off;
saveas(gcf, 'grid_plot_32_32.png');

