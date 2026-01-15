% Generate sine wave data
t = 0:0.01:2*pi;        
sin_wave = sin(t);      

% Split into training and testing data
trainData = sin_wave(1:end-10);  
testData = sin_wave(end-9:end);  

% Prepare the input and target sequences for the LSTM
XTrain = trainData(1:end-1);  
YTrain = trainData(2:end);    

XTrain = num2cell(XTrain, 2); 
YTrain = num2cell(YTrain, 2); 


% Define the LSTM architecture
numHiddenUnits = 50; 
layers = [
    sequenceInputLayer(1)                        
    lstmLayer(numHiddenUnits, 'OutputMode', 'last') 
    fullyConnectedLayer(1)                      
    regressionLayer                                
];

% Display the network architecture
disp(layers);


% Training options
options = trainingOptions('adam', ...          
    'MaxEpochs', 100, ...                         
    'GradientThreshold', 1, ...                    
    'InitialLearnRate', 0.01, ...                  
    'Verbose', 0, ...                              
    'Plots', 'training-progress');                 

% Train the network
net = trainNetwork(XTrain, YTrain, layers, options);


% Predict the sine wave using the trained network
YPred = predict(net, XTrain);

% Plot the actual vs predicted sine wave
figure;
plot(1:length(trainData)-1, trainData(2:end), '-b', 'LineWidth', 1.5);  % Actual data
hold on;
plot(1:length(trainData)-1, cell2mat(YPred), '-r', 'LineWidth', 1.5);  % Predicted data
legend('True Sine Wave', 'Predicted Sine Wave');
title('LSTM Prediction of Sine Wave');
xlabel('Time Step');
ylabel('Amplitude');


% Prepare test data (same format as training data)
XTest = testData(1:end-1);
YTest = testData(2:end);

XTest = num2cell(XTest, 2);
YTest = num2cell(YTest, 2);

% Predict using the trained network
YPredTest = predict(net, XTest);

% Plot the test results
figure;
plot(1:length(testData)-1, testData(2:end), '-b', 'LineWidth', 1.5);  % Actual data
hold on;
plot(1:length(testData)-1, cell2mat(YPredTest), '-r', 'LineWidth', 1.5);  % Predicted data
legend('True Sine Wave (Test)', 'Predicted Sine Wave');
title('RNN Prediction on Test Data');
xlabel('Time Step');
ylabel('Amplitude');
