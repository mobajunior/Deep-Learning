% Nom: Moussa Bâ

% Au cours de cet exercice, nous allons implémenter différentes fonctions, pour 
% pourvoir réaliser une régression logistique sur des notes d'un étudiant 
% qui a fait deux examens afin de voir son admissibilité ou non

% Recupération des données depuis un fichier texte
data = load('tp2data1.txt');

% x1 représente les notes de l'examen 1
x1 = data(:, 1);
% x2 représente les notes de l'examen 2
x2 = data(:, 2);

% Classification des notes selon admis(1) ou non damis(0)
y = data(:,3);

% Affichage des données d'appprentissage
gscatter(x1, x2, y, 'rb', 'oo')
legend('non admis', 'admis');
xlabel('notes de l’examen 1');
ylabel('notes de l’examen 2');
hold off;


% X est la matrice comprenant les notes des deux examens
X = [x1, x2];

% m représente le nombre de note(nombre de données) qu'on a pour chaque examen 
% tandis que n représente le nombre de d'examens(nombre de caractéristiques) qu'on a 
[m, n] = size(X);

% Mis à jour de X, matrice comprenant notes des deux examens incluant
% x0+1 x m comprenant
X =[ones(m, 1), x1, x2];

% Initial theta
initial_theta = zeros(n + 1, 1);

% Calcul de la sigmoïde avec des paramètres connus
% Soit z le tableau donné
z = [0, 5, -5];
nb = length(z);
% On calcule pour la sigmoïde pour chaque z
for i = 1:nb
    test_sigmoid = sigmoid(z(i));
    fprintf('Valeur de sigmoid pour z %f = ', z(i));
    fprintf('%f\n', test_sigmoid);
end

% Calcul du coût et des gradients
[J, grad] = costFunction(initial_theta, X, y);

% Affichage du coût et des gradients pour thetas initialisés à 0
fprintf('\nValeur de la fonction de coût pour thetas initialisés à 0: %f\n', J);
fprintf('Valeurs des gradients pour theta initialisés à 0: \n');
fprintf(' %f \n', grad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Calcul des theta et du coût après optimisation%%%%%%%%%%%%%%%%%%%%

% Options de calcul des thetas et du coût
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Fonction nous permettant de calculer  les thetas et le coût
% Vue que theta change à chaque theta on le référante à th
[theta, J] = fminunc(@(th)(costFunction(th, X, y)), initial_theta, options);

% Affichage des valeur de theta après appel de la fonction fminunc
fprintf('Valeur de theta après optimisation: \n');
fprintf('%f \n', theta);

% Affichage du coût après appel de la fonction fminunc
fprintf('\nValeur de la fonction de coût après optimisation: %f\n', cost);

% Soit X reprsentant les notes obtenues pour les 2 examens incluant x0
X = [1, 45, 85];

% On calcule la prédiction qu'il soit admis ou non
prediction = sigmoid(X * theta);
prediction = prediction*100;

% Puis on affiche dans la figure précédente, selon:
hold on
% qu''il soit admis avec un rond en bleu superposé avec le signe "+"
if prediction > 0.5
    gscatter(45, 85, prediction, 'b', 'o')
    gscatter(45, 85, prediction, 'b', '+')
    legend('admis', 'non admis');
    xlabel('notes de l’examen 1');
    ylabel('notes de l’examen 2');
    hold off;
    print('prediction_admission','-dpng')
else
    % qu''il ne soit pas admis avec un rond en rouge superposé avec le signe "+"
    gscatter(45, 85, prediction, 'r', 'o')
    gscatter(45, 88, prediction, 'r', '+')
    legend('admis', 'non admis');
    xlabel('notes de l’examen 1');
    ylabel('notes de l’examen 2');
    hold off;  
end

fprintf(['\nPour un étudiant qui a 45 au premier examen et 85 au deuxième examen, '...
    ' la probailité d''admission est de %f'], prediction);
fprintf(' pourcents\n');
