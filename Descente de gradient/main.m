%Nom: Moussa Bâ

%main est le script qui va nous permetter de calculer l'hypothèse, les
%probabilité et la fonction de coût
%variables d'entrée

X=load('tp1x.dat');
%variables de sortie
Y=load('tp1y.dat');

plot(X, Y, '.');
ylabel('Taille');

xlabel('Age');
title('Taille en fonction de l''âge');

temp0=0;
temp1=0;

%Taux d'apprentissage
alpha=0.07;

%nombre d'exemple d'entrainement
m=length(X);

%on rajoute à X une dimension pour calculer les theta avec une matrice
X=[ones(m, 1), X];

%Theta est une matrice qui définit Theta0 pour la 1ère rangée et Theta1
%pour la deuxième rangée
theta=zeros(2,1);

%nombre d'itération pour Theta ave la descente de gradient
iteration=1500;

%Calcul de Theta avec la descente de gradient
theta=Descente_gradient(theta, alpha, X, Y, iteration, m);

%Affichage de Theta
fprintf('\n Valeurs de Theta trouvées par descente de gradient');
fprintf('\n Theta0 = ');
fprintf('%f \n', theta(1));
fprintf('\n Theta1 = ')
fprintf('%f \n', theta(2));
hold on 
plot(X(:, 2), X*theta, '-');
legend('Données d''entrainement', 'Régression linéaire');
hold off;

%Prédisons les tailles des enfants selon l'âge donné dans le tableau
fprintf('Prédiction des tailles en fonction de l''âge \n');

%Tableu contenant âges des enfants dont on veut prédire leurs tailles
tab=[3.5, 5, 5.5, 7];
predict=ones(1,4);

for i=1:4
  %calcul de la prédiction de la taille pour chaque pour chaque enfant
  predict(i)=[1, tab(i)]*theta;
  %Affichage des prédictions
  fprintf('Prédiction taille pour enfant de l''âge de ');
  fprintf('%f ans = ', tab(i));
  fprintf('%f \n \n', predict(i));
end
hold on;
%eAffichage des prédictions
plot(tab, predict, 'x');
legend('Données d''entrainement', 'Régression linéaire', 'Prédictions des tailles');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%Visualisation de la fonction de coût%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J_vals = zeros(100, 100); % initialize Jvals to 100x100 matrix of 0's
theta0_vals = linspace(-3, 3, 100);
theta1_vals = linspace(-1, 1, 100);
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
        t = [theta0_vals(i); theta1_vals(j)];
        J_vals(i,j) = (1/(2*m))*((((X*t)-Y).^2)'*X(:, 1));
    end
end
% Plot the surface plot
% Because of the way meshgrids work in the surf command, we need to
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals'; 
figure;
surf(theta0_vals, theta1_vals, J_vals) 
xlabel('\theta_0');
ylabel('\theta_1')
figure;

% Plot the cost function with 15 contours spaced logarithmically
% between 0.01 and 100
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 2, 15))
xlabel('\theta_0'); ylabel('\theta_1')
