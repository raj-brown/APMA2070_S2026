function [loss,gradients] = modelLoss(parameters, x, y)

% Make predictions with the input data.
y_pred = model(parameters, x);

loss = mse(y_pred, y);
% Calculate gradients with respect to the learnable parameters.
gradients = dlgradient(loss, parameters);

end