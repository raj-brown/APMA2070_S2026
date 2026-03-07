% Test the manual convolution function
A = [0, 1 2 ; 3 4 5; 6 7 8]; % Input matrix (image or signal)
B = [0 1; 2 3]; % Kernel (filter)

% Perform manual convolution
output = manualConvolution(A, B);
% Display the result
disp('Result of Manual Convolution:');
disp(output);

function result = manualConvolution(A, B)
    % Get the size of input matrix A and kernel B
    [mA, nA] = size(A); % Size of the input array
    [mB, nB] = size(B); % Size of the kernel (filter)
     
    % Prepare the result matrix (same size as input array A)
    result = zeros(mA-mB+1, nA-nB+1);
    rc = size(result);    
    % Perform the convolution
    for i = 1:rc(1)
        for j = 1:rc(2)
            % Extract the region of the image corresponding to the filter size
            region = A(i:i+mB-1, j:j+nB-1);            
            % Perform element-wise multiplication and sum the result
            result(i, j) = sum(sum(region .* B));
        end
    end
end