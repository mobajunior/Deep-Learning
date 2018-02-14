function[J, grad] = costFunction(theta, X, y)
    % Calcul de l'hypothèse
    hypothese = sigmoid(X * theta);
   
    % Nombre de données d'entraînement
    m = length(y);
    
    % Cas propable que l'étudiant soit admis
    positive_prediction = -y .* log(hypothese);
    
    % Cas probable que l'étudiant ne soit pas admis
    negative_prediction =(1 - y) .* log(1 - hypothese);
    
    % Calcul du coût
    J = (1 / m) * sum(positive_prediction - negative_prediction);
    
    % Calcul des gradients
    grad = (1 / m) * ((hypothese - y)' * X);
    
end