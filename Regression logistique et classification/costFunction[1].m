function[J, grad] = costFunction(theta, X, y)
    % Calcul de l'hypoth�se
    hypothese = sigmoid(X * theta);
   
    % Nombre de donn�es d'entra�nement
    m = length(y);
    
    % Cas propable que l'�tudiant soit admis
    positive_prediction = -y .* log(hypothese);
    
    % Cas probable que l'�tudiant ne soit pas admis
    negative_prediction =(1 - y) .* log(1 - hypothese);
    
    % Calcul du co�t
    J = (1 / m) * sum(positive_prediction - negative_prediction);
    
    % Calcul des gradients
    grad = (1 / m) * ((hypothese - y)' * X);
    
end