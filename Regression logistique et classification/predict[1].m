function p = predict(theta, X)    
    % Calcul de la pr�diction pour les notes don�es pour les examens
    p = sigmoid(X * theta);
end