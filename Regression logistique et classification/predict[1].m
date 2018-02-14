function p = predict(theta, X)    
    % Calcul de la prédiction pour les notes donées pour les examens
    p = sigmoid(X * theta);
end