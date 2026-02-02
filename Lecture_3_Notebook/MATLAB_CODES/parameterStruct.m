function parameters = parameterStruct(numLayers, numNeurons)
sz = [numNeurons 1];
parameters.fc1.Weights = initializeHe(sz,2,"single");
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