%fonction qui nous permet de calculer les Theta avec la descente de
%gradient
function theta=Descente_gradient(theta, alpha, X, Y, iteration, m)
    for i=1:iteration      
        hypothese=(X*theta);
        %calcul de Theta0
        theta(1, 1)=theta(1, 1) -alpha*(1/m)*((hypothese-Y)'*(X(:, 1)));
        %Clacul de Theta1
        theta(2, 1)=theta(2, 1) -alpha*(1/m)*((hypothese-Y)'*(X(:, 2)));
    end
        
end