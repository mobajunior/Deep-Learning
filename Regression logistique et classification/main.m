% Nom: Moussa B�
% NI: A00170392
% TP2
% Au cours de ce tp, nous allons impl�menter diff�rentes fonctions, pour 
% pourvoir r�aliser une r�gression logistique sur des notes d'un �tudiant 
% qui a fait deux examens afin de voir son admissibilit� ou non

% Recup�ration des donn�es depuis un fichier texte
data = load('tp2data1.txt');

% x1 repr�sente les notes de l'examen 1
x1 = data(:, 1);
% x2 repr�sente les notes de l'examen 2
x2 = data(:, 2);

% Classification des notes selon admis(1) ou non damis(0)
y = data(:,3);

% Affichage des donn�es d'appprentissage
gscatter(x1, x2, y, 'rb', 'oo')
legend('non admis', 'admis');
xlabel('notes de l�examen 1');
ylabel('notes de l�examen 2');
hold off;


% X est la matrice comprenant les notes des deux examens
X = [x1, x2];

% m repr�sente le nombre de note(nombre de donn�es) qu'on a pour chaque examen 
% tandis que n repr�sente le nombre de d'examens(nombre de caract�ristiques) qu'on a 
[m, n] = size(X);

% Mis � jour de X, matrice comprenant notes des deux examens incluant
% x0+1 x m comprenant
X =[ones(m, 1), x1, x2];

% Initial theta
initial_theta = zeros(n + 1, 1);

% Calcul de la sigmo�de avec des param�tres connus
% Soit z le tableau donn�
z = [0, 5, -5];
nb = length(z);
% On calcule pour la sigmo�de pour chaque z
for i = 1:nb
    test_sigmoid = sigmoid(z(i));
    fprintf('Valeur de sigmoid pour z %f = ', z(i));
    fprintf('%f\n', test_sigmoid);
end

% Calcul du co�t et des gradients
[J, grad] = costFunction(initial_theta, X, y);

% Affichage du co�t et des gradients pour thetas initialis�s � 0
fprintf('\nValeur de la fonction de co�t pour thetas initialis�s � 0: %f\n', J);
fprintf('Valeurs des gradients pour theta initialis�s � 0: \n');
fprintf(' %f \n', grad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Calcul des theta et du co�t apr�s optimisation%%%%%%%%%%%%%%%%%%%%

% Options de calcul des thetas et du co�t
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Fonction nous permettant de calculer  les thetas et le co�t
% Vue que theta change � chaque theta on le r�f�rante � th
[theta, J] = fminunc(@(th)(costFunction(th, X, y)), initial_theta, options);

% Affichage des valeur de theta apr�s appel de la fonction fminunc
fprintf('Valeur de theta apr�s optimisation: \n');
fprintf('%f \n', theta);

% Affichage du co�t apr�s appel de la fonction fminunc
fprintf('\nValeur de la fonction de co�t apr�s optimisation: %f\n', cost);

% Soit X reprsentant les notes obtenues pour les 2 examens incluant x0
X = [1, 45, 85];

% On calcule la pr�diction qu'il soit admis ou non
prediction = sigmoid(X * theta);
prediction = prediction*100;

% Puis on affiche dans la figure pr�c�dente, selon:
hold on
% qu''il soit admis avec un rond en bleu superpos� avec le signe "+"
if prediction > 0.5
    gscatter(45, 85, prediction, 'b', 'o')
    gscatter(45, 85, prediction, 'b', '+')
    legend('admis', 'non admis');
    xlabel('notes de l�examen 1');
    ylabel('notes de l�examen 2');
    hold off;
    print('prediction_admission','-dpng')
else
    % qu''il ne soit pas admis avec un rond en rouge superpos� avec le signe "+"
    gscatter(45, 85, prediction, 'r', 'o')
    gscatter(45, 88, prediction, 'r', '+')
    legend('admis', 'non admis');
    xlabel('notes de l�examen 1');
    ylabel('notes de l�examen 2');
    hold off;  
end

fprintf(['\nPour un �tudiant qui a 45 au premier examen et 85 au deuxi�me examen, '...
    ' la probailit� d''admission est de %f'], prediction);
fprintf(' pourcents\n');
