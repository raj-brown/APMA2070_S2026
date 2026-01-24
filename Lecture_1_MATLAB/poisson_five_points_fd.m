% 5-point finite difference stencil for 2D Poisson problem
% Domain: [0,1] x [0,1]
% Exact solution: u(x,y) = sin(pi*x)*sin(pi*y)
% Boundary condition: u = 0 on boundary

clear; clc; close all;

%% Parameters
Nx = 32;             % Number of interior points in x
Ny = 32;             % Number of interior points in y

hx = 1/(Nx+1);       % Grid spacing in x
hy = 1/(Ny+1);       % Grid spacing in y

% Interior grid points (exclude boundary)
x = (1:Nx)*hx;
y = (1:Ny)*hy;
[X,Y] = meshgrid(x,y);

%% Exact solution and RHS
u_exact = sin(pi*X).*sin(pi*Y);
f = -2*pi^2 * sin(pi*X).*sin(pi*Y);

%% Build 1D second derivative matrices
ex = ones(Nx,1);
ey = ones(Ny,1);

Tx = spdiags([ex -2*ex ex], [-1 0 1], Nx, Nx) / hx^2;
Ty = spdiags([ey -2*ey ey], [-1 0 1], Ny, Ny) / hy^2;

Ix = speye(Nx);
Iy = speye(Ny);

%% 2D Laplacian for interior points
A = kron(Iy, Tx) + kron(Ty, Ix);

%% Solve linear system for interior points
b = f(:);
u_interior = A\b;

%% Expand solution to full grid including boundary
u_full = zeros(Ny+2, Nx+2);
u_full(2:end-1,2:end-1) = reshape(u_interior, Ny, Nx);

%% Full grid including boundary for plotting
x_full = 0:hx:1;
y_full = 0:hy:1;
[X_full,Y_full] = meshgrid(x_full, y_full);

%% Exact solution including boundary
u_exact_full = sin(pi*X_full).*sin(pi*Y_full);

%% Compute errors
error_abs_inf = max(max(abs(u_full - u_exact_full)));   % Infinity norm
error_abs_l2  = sqrt(sum(sum((u_full - u_exact_full).^2)) * hx * hy); % L2 norm
norm_exact_l2 = sqrt(sum(sum(u_exact_full.^2)) * hx * hy);
error_rel_l2  = error_abs_l2 / norm_exact_l2;           % Relative L2

fprintf('Infinity norm error: %e\n', error_abs_inf);
fprintf('Absolute L2 error:   %e\n', error_abs_l2);
fprintf('Relative L2 error:   %e\n', error_rel_l2);

%% Surface plot of numerical solution
figure;
surf(X_full, Y_full, u_full);
title(sprintf('Numerical Solution (5-point stencil) N=%d', Nx));
xlabel('x'); ylabel('y'); zlabel('u');
shading interp; colorbar; axis tight;
exportgraphics(gcf, sprintf('Solution_N=%d.png', Nx), 'Resolution', 300);

%% Contour plot of numerical solution
figure;
contourf(X_full, Y_full, u_full, 30, 'LineColor','none');
colorbar; axis equal tight;
title(sprintf('Contour Plot of Numerical Solution N=%d', Nx));
xlabel('x'); ylabel('y');
exportgraphics(gcf, sprintf('Contour_Solution_N=%d.png', Nx), 'Resolution', 300);

%% Surface plot of absolute error
figure;
surf(X_full, Y_full, abs(u_full - u_exact_full));
title(sprintf('Pointwise Absolute Error N=%d', Nx));
xlabel('x'); ylabel('y'); zlabel('|u_{num}-u_{exact}|');
shading interp; colorbar; axis tight;
exportgraphics(gcf, sprintf('AbsError_N=%d.png', Nx), 'Resolution', 300);

%% Contour plot of relative error
figure;
rel_error_plot = abs(u_full - u_exact_full)./abs(u_exact_full + eps); % avoid div by 0
contourf(X_full, Y_full, rel_error_plot, 30, 'LineColor','none');
colorbar; axis equal tight;
title(sprintf('Pointwise Relative Error N=%d', Nx));
xlabel('x'); ylabel('y');
exportgraphics(gcf, sprintf('RelError_N=%d.png', Nx), 'Resolution', 300);
