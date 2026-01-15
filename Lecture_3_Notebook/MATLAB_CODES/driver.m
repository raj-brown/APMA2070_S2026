clc;
clear all;

%% Code for Function regression
% Data Generation
% Define f(x) using anonymous definition 
f = @(x) (x < 0).* (5.0 + sin(x) + sin(2.0*x) + ...
     sin(3.0*x) + sin(4.0*x)) + (x>=0) .* cos(10*x);

% Training and Testing data
x_in_l = linspace(-pi, -1.0e-3, 201);
x_in_r = linspace(0., pi, 501);
y_in_l = f(x_in_l);
y_in_r = f(x_in_r);
x_in = [x_in_l, x_in_r];
y_in = [y_in_l, y_in_r];
X = [x_in_l x_in_r ];
Y = [y_in_l y_in_r];

%% Parameters Initialization
parameters = struct;
numLayers = 2;
numNeurons = 40;
sz = [numNeurons 1];
parameters.fc1.Weights = initializeHe(sz,1,"single");
parameters.fc1.Bias = initializeZeros([numNeurons 1],"single");
for layerNumber=2:numLayers-1
    name = "fc"+layerNumber;
    sz = [numNeurons numNeurons];
    numIn = numNeurons;
    parameters.(name).Weights = initializeHe(sz,numIn,"single");
    parameters.(name).Bias = initializeZeros([numNeurons 1],"single");
end
sz = [1 numNeurons];
numIn = numNeurons;
parameters.("fc" + numLayers).Weights = initializeHe(sz,numIn, "single");
parameters.("fc" + numLayers).Bias = initializeZeros([1 1], "single");

sz_in = size(X);
numEpochs = 60000;
miniBatchSize = sz_in(2);
executionEnvironment = "auto";
learningRate = 0.001;
ds = arrayDatastore(X);

mbq = minibatchqueue(ds, ...
    MiniBatchSize=miniBatchSize, ...
    MiniBatchFormat="CB", ...
    OutputEnvironment=executionEnvironment);
Y = dlarray(Y, "CB");

if (executionEnvironment == "auto" && canUseGPU) || ...
        (executionEnvironment == "gpu")
    X = gpuArray(X);
    Y = gpuArray(Y);
end

averageGrad = [];
averageSqGrad = [];
lossHist = zeros(numEpochs,1);
accfun = dlaccelerate(@modelLoss);
start = tic;
iteration = 0;
for epoch = 1:numEpochs
    reset(mbq);
    while hasdata(mbq)
        iteration = iteration + 1;
        X = next(mbq);
        [loss,gradients] = dlfeval(accfun, parameters,X,Y);
        [parameters,averageGrad,averageSqGrad] = adamupdate(parameters,...
            gradients,averageGrad, ...
            averageSqGrad,iteration,learningRate);
    end
    loss = double(gather(extractdata(loss)));
    lossHist(epoch) = loss;
    D = duration(0,0,toc(start),Format="hh:mm:ss");
    fprintf('On Epoch: %d, and Loss %f\n', epoch, loss)   
end
toc;

 Y_pred = model(parameters,X);
 close;
 plot(X, Y_pred, "-r", LineWidth=2.0); hold on
 plot(X, Y, "--b", LineWidth=1.0);
 xlabel("x")
 ylabel("f(x)")
 legend('Predicetd','Reference')
 fontsize(gcf,scale=2)
 saveas(gcf,"function_plot.png")

 ep = 1:1:numEpochs;
 figure;
 semilogy(ep, lossHist, "-k", LineWidth=2.0)
 xlabel("# Iteration")
 ylabel("Loss")
 fontsize(gcf,scale=2)
  saveas(gcf,"Loss.png")



 


