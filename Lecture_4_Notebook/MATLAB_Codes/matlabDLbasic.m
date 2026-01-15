%% From native matlab array to dl array

% Create a numeric array
data = rand(28, 28, 3, 10); % Example: 28x28 RGB images, 10 samples

% Convert to dlarray
dl_data = dlarray(data, 'SSCB');
% 'SSCB' indicates dimensions:
% S: Spatial (28x28)
% C: Channel (3)
% B: Batch (10)

%% Directly creating dlarray
dl_data = dlarray(rand(5, 10), 'CB');
% C: Channel (5), B: Batch (10)


%% Unlabeled Dimensions
dl_data = dlarray(rand(28, 28, 3, 10)); % No labels


%% Opeartions on dlarray
% Create two dlarrays
a = dlarray(rand(3, 3), 'SS');
b = dlarray(rand(3, 3), 'SS');

% Element-wise addition
c = a + b;

% Reshape while preserving labels
reshaped_a = reshape(a, [9, 1]);

% Permute dimensions
permuted_a = permute(a, [2, 1]); % Swap dimensions

% Converting back to numeric arrays
numeric_data = extractdata(dl_data);

% Define a dlarray for a 4D tensor
% Create a batch of 10 4D tensor, size 28x28
image_data = rand(28, 28, 1, 10); % 28x28, 1 channel, 10 samples
dl_image = dlarray(image_data, 'SSCB');
disp('Dimension labels of dlarray:');
disp(dl_image);


%% Training Workflow
% Define input and target data
X = dlarray(rand(100, 32)); 
Y = dlarray(rand(10, 32));  

% Perform a forward pass through a simple fully connected layer
weights = dlarray(rand(10, 100));
bias = dlarray(rand(10, 1));
Z = weights * X + bias;

% Apply softmax activation
predictions = softmax(Z, 'DataFormat', 'CB');
disp(predictions);

%% If you want to visualize or inspect the dlarray:
% Check size and labels
disp(size(dl_image));
disp(dims(dl_image));

% Extract numeric data for visualization
numeric_image = extractdata(dl_image);

% Display the first image in the batch
imshow(numeric_image(:, :, 1, 1));


%% dlgradient: Rosebrock scalar function
x0 = dlarray([-1,2]);
[fval,gradval] = dlfeval(@rosenbrock,x0);



%% dlgradient Rosebrock scalar 2D function
x1 = dlarray(-1);
x2 = dlarray(2);
[fval,dydx1,dydx2] = dlfeval(@rosenbrock2,x1,x2);


function [y,dydx] = rosenbrock(x)
y = 100*(x(2) - x(1).^2).^2 + (1 - x(1)).^2;
dydx = dlgradient(y,x);
end


function [y,dydx1,dydx2] = rosenbrock2(x1,x2)
y = 100*(x2 - x1.^2).^2 + (1 - x1).^2;
[dydx1,dydx2] = dlgradient(y,x1,x2);
end

