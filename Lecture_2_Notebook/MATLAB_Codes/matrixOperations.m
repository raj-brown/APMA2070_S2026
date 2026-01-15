% Define two matrices
A = [1 2 3; 4 5 6; 7 8 9];
B = [9 8 7; 6 5 4; 3 2 1];
% Matrix Addition
C_add = A + B; % Element-wise addition

% Matrix Subtraction
C_sub = A - B; % Element-wise subtraction

% Matrix Multiplication
C_mul = A * B; % Standard matrix multiplication
C_elem_mul = A .* B; % Element-wise multiplication

% Transpose of a Matrix
A_trans = A';

% Inverse of a Matrix (if invertible)
% Note: A is singular in this case; we'll use another matrix
A_invertible = [1 2; 3 4];
A_inv = inv(A_invertible);

% Eigenvalues and Eigenvectors
[eig_vectors, eig_values] = eig(A_invertible);

% Singularvalue of a non square matrix
X = rand(10, 8);
[U,S,V] = svd(X);

% Display Results
disp('Matrix A:');
disp(A);
disp('Matrix B:');
disp(B);
disp('Matrix Addition (A + B):');
disp(C_add);
disp('Matrix Subtraction (A - B):');
disp(C_sub);
disp('Matrix Multiplication (A * B):');
disp(C_mul);
disp('Element-wise Multiplication (A .* B):');
disp(C_elem_mul);
disp('Transpose of A:');
disp(A_trans);
disp('Inverse of A_invertible:');
disp(A_inv);
disp('Eigenvalues of A_invertible:');
disp(diag(eig_values));
disp('Eigenvectors of A_invertible:');
disp(eig_vectors);

disp('Singular values of X:');
disp(diag(S));
disp('Left singular vector:');
disp(U);
disp('Right singular vector:');
disp(V);
