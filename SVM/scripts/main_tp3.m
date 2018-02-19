%Nom: Moussa B�
%NI: A00170392
%TP4
%Au cours de ce tp nous allons d�velopper un syst�me de classification en
%utilisant les SVM pour classifier des pixels d'une image comme �tant des
%pixels feu ou non feu

%%
%Chemin du r�pertoire o� se trouve les images du dossier bdfire_Red_1
d = dir('D:\bdfire_Red_1');
isub = [d(:).isdir];
folders = {d(isub).name}';
folders(ismember(folders,{'.','..'})) = [];

% xfire et x_not_fire sont des matrices qui vont contenir les coordonn�es
% selon l'axe des x, des r�gions de 10x10 de r�gion de feu et de non feu
x_fire = zeros(2, 3);
x_not_fire = zeros(2, 3);
% yfire et y_not_fire sont des matrices qui vont contenir les coordonn�es
% selon l'axe des y, des r�gions de 10x10 de r�gion de feu et de non feu
y_fire = zeros(2, 3);
y_not_fire = zeros(2, 3);

%f_fire et f_not_fire sont des matrices qui vont comprendre toutes les
%caract�ristiques selon les canaux pour chaque pixel
f_fire = [];
f_not_fire = [];

%Variables qui d�finissent les coordonb�es des r�gions de feu
x1_fire = [];
x2_fire = [];
y1_fire = [];
y2_fire = [];

%Variables qui d�finissent les coordonb�es des r�gions de non feu
x1_not_fire = [];
x2_not_fire = [];
y1_not_fire = [];
y2_not_fire = [];

tab_name_img_train = [];

%Apprentissage pour 15 images
for i = 1 : 15
    num_img = num2str(i);
    
    %location d�finit le chemin du dossier o� se trouve les images, selon
    %leur ordonnance
    location=strcat('D:\bdfire_Red_1\', folders(i), '\*.png');
    %srcFiles d�finit les fichiers  de type image qui se trouvent dans le
    %dossier
    srcFiles = dir(location{1});
    %Nous allons parcourir les images du dossiers � savoir gt et rgb
    for j = 1 : length(srcFiles)
        filename = strcat('D:\bdfire_Red_1\', folders(i), '\', srcFiles(j).name);
        I = imread(filename{1});
        %En premier lieu, nous allons extraire les r�gions de feux pour les
        %image gr�ce au ground truth
        if j == 1
            %La premi�re image du dossier repr�sente l'image ground truth
            gt = I;
            %nous allons recup�rer les coordonn�es de trois r�gions de feux et
            %de non feux
            [x_fire, y_fire] = get_pixel_fire(gt);
            [x_not_fire, y_not_fire] = get_pixel_not_fire(gt);
            
            %x1_fire et x2_fire sont des coordonn�es qui repr�sentent
            %l'intervalle o� d�bute la r�gion de feu jusqu'� la fin selon
            %l'axe des x
            x1_fire = [x1_fire; x_fire(1,:).'];
            x2_fire = [x2_fire;  x_fire(2,:).'];
            
            %y1_fire et y2_fire sont des coordonn�es qui repr�sentent
            %l'intervalle o� d�bute la r�gion de feu jusqu'� la fin selon
            %l'axe des y
            y1_fire = [y1_fire; y_fire(1,:).'];
            y2_fire = [y2_fire; y_fire(2,:).'];
            
            %On fait de m�me pour les coordonn�es des non feux
            x1_not_fire = [x1_not_fire; x_not_fire(1,:).'];
            x2_not_fire = [x2_not_fire; x_not_fire(2,:).'];
            y1_not_fire = [y1_not_fire; y_not_fire(1,:).'];
            y2_not_fire = [y2_not_fire; y_not_fire(2,:).'];
        end
        
        %Apr�s avoir recup�r� les r�gions de feux, on extrait les
        %caract�ristiques  de l'image rgb
        if j == 2
            %tableau contenant les noms des images
            tab_name_img_train{i} = srcFiles(j).name;
            
            %rgb repr�sente l'image de type rgb
            rgb = I;
            %Nous allons extraire les caract�ristiques des trois r�gions de
            %feu et de non feu
            for l = 1:3
                %Pour chaque r�gion de feu ou non feu, nous allons extraire les
                %caract�ristiques en passant en param�tres � la fonction
                %get_caracteristic les coordonn�es de la zone de feu selon
                %l qui repr�sente le num�ro de la zone de feu ou non feu
                [f_fire_region] = get_caracteristic(rgb, x_fire(1, l), x_fire(2, l), y_fire(1, l), y_fire(2, l));
                [f_not_fire_region] = get_caracteristic(rgb, x_not_fire(1, l), x_not_fire(2, l), y_not_fire(1, l), y_not_fire(2, l));
                
                %On fait la transpos�e des vecteurs de caract�ristiques feu
                %et non feu pour agencer la valeur du pixel selon sa
                %position
                f_fire_region = f_fire_region.';
                f_not_fire_region = f_not_fire_region.';
                
                %puis on fais une concat�nation des vecteurs de
                %caract�ristiques pour les trois zones et de non feu
                f_fire = [f_fire; f_fire_region];
                f_not_fire = [f_not_fire; f_not_fire_region];
            end
        end
    end
    %Cr�ation du r�pertoire fire_regions
    mkdir ../script fire_regions
    
    %file_name_fire d�finit le nom de l'image avec les r�gions de feu sous
    %forme de recatngle qu'on va sauvegarder dans le dossier sp�cifi�
    %dans le r�pertoire �nonc� ci-dessus
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\fire_regions\img_region_fire', num_img);
    
    imshow(I); title('Captures regions de feux');
    
    rectangle('Position',[y_fire(1, 1), x_fire(1, 1), 10, 10], 'EdgeColor', 'g')
    rectangle('Position',[y_fire(1, 2), x_fire(1, 2), 10, 10], 'EdgeColor', 'g')
    rectangle('Position',[y_fire(1, 3), x_fire(1, 3), 10, 10], 'EdgeColor', 'g')
    print(gcf, '-dpng', repertory);
    clf('reset')   
    
    %on va afficher les regions de feu selon les canaux gr�ce � la fonction
    %save_img qui va prendre en param�tres les coordonn�es des trois
    %r�gions de feux et le nom auquel on veut sauvegarder cette image
    file_name_fire_region = tab_name_img_train(i);
    save_img(I, x_fire, y_fire, file_name_fire_region{1});
    clf('reset')

end

%On va sauvegarder un fichier excel contenant les coordonn�es des r�gions de feux de 15images  
x_excel = [x1_fire, x2_fire, y1_fire, y2_fire];%, x1_not_fire, x1_not_fire, y1_notfire, y2_not_fire];

col_header={'Noms image', 'X1','X2', 'Y1', 'Y2'};

row_header = cell(45, 1);
%Nous allons d�finir les noms de l'images et le num�ro de zone pour chacune
%des images trait�es
%%
cpt3 = 1;
for cpt1=1:15
    name_img_excel = tab_name_img_train(cpt1);
    %name_img = strcat('image', num_img_excel);
    zone_name = strcat(name_img_excel, '_zone_');
    for cpt2=1:3
        nb_zone = num2str(cpt2);
        nb_zone_name = strcat(zone_name, nb_zone);
        row_header{cpt3} = nb_zone_name{1};
        cpt3 = cpt3 + 1;
    end
end

%Cr�ation du fichier excel
xlswrite('coord_fire.xls',x_excel,'Sheet1','B2');
xlswrite('coord_fire.xls',col_header,'Sheet1','A1');
xlswrite('coord_fire.xls',row_header,'Sheet1','A2');
%%
%%
%X repr�sente une matrice qui contient tous les pixels des r�gions de feux
%et non feux pour les trois zones des 15 images qu'on a trait�es selonn les
%canaux 
X = [f_fire; f_not_fire];
[height, width, dim] = size(X);

%On va d�finir la variable Y qui est un vecteur qui vailde si les pixels
%qui se trouvent dans la matrice X sont feu ou non feu
Y_fire = ones(height/2, 1); 
Y_not_fire = zeros(height/2, 1);
Y = [Y_fire; Y_not_fire];
[height, width, dim] = size(Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%Validation%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Cr�ation de r�pertoires pour sauvegarder les images selon le mod�le
mkdir ../script linear
mkdir ../script rbf
mkdir ../script gaussian
mkdir ../script polynomial

%Pour chaque type de mod�le, on va modifier le C et voir celui qui donne le
%meilleur F1 score
%avg_ suivi du nom du mod�le repr�sente la moyenne du F1 score
% de m�me que ecart_type pour l'�cart type du mod�le

%Lin�aire
[SVMModel_linear, avg_linear, ecart_type_linear, BoxConstraint_linear, KernelScale_linear] = get_best_model(X, Y, 'linear', folders);
fprintf('Moyenne F1_score lin�aire = %d\n', avg_linear);
fprintf('�cart type F1_score lin�aire = %d\n', ecart_type_linear);
fprintf('BoxConstraint linear = %d\n', BoxConstraint_linear);
fprintf(' KernelScale linear = %d\n\n', KernelScale_linear);

%RBF
[SVMModel_rbf, avg_rbf, ecart_type_rbf, BoxConstraint_rbf, KernelScale_rbf] = get_best_model(X, Y, 'rbf', folders);
fprintf('Moyenne F1_score rbf = %d\n', avg_rbf);
fprintf('�cart type F1_score rbf = %d\n', ecart_type_rbf);
fprintf('BoxConstraint RBF = %d\n', BoxConstraint_rbf);
fprintf('KernelScale RBF = %d\n\n', KernelScale_rbf);

%Gaussien
[SVMModel_gauss, avg_gauss, ecart_type_gauss, BoxConstraint_gauss, KernelScale_gauss] = get_best_model(X, Y, 'gaussian', folders);
fprintf('Moyenne F1_score Gaussien = %d\n', avg_gauss);
fprintf('�cart type F1_score Gaussien = %d\n', ecart_type_gauss);
fprintf('BoxConstraint Gaussien = %d\n', BoxConstraint_gauss);
fprintf(' KernelScale Gaussien = %d\n\n', KernelScale_gauss);

%Polynomial
[SVMModel_poly, avg_poly, ecart_type_poly, BoxConstraint_poly, KernelScale_poly] = get_best_model(X, Y, 'polynomial', folders);
fprintf('Moyenne F1_score polynomial = %d\n', avg_poly);
fprintf('�cart type F1_score polynomial = %d\n', ecart_type_poly);
fprintf('BoxConstraint polynomial = %d\n', BoxConstraint_poly);
fprintf('KernelScale Gaussien = %d\n\n', KernelScale_poly);

%Apr�s avoir cherch� les mailleurs mod�les, on prend les trois meilleurs en
%�liminant le minimum des 4
tab_f1_score = [avg_linear avg_rbf avg_gauss avg_poly];
[min_f1_score, index_f1_score] = min(tab_f1_score);
%%
tab_f1_score_gauss = [];
tab_f1_score_linear = [];
tab_f1_score_rbf = [];
tab_f1_score_poly = [];


row_header = cell(45, 1);

%tableau contenant les noms des images
tab_name_img = [];
%Application du SVModel pour toutes les images
for i = 1 : 30
    num_img = num2str(i);
    location=strcat('D:\bdfire_Red_1\', folders(i), '\*.png');
    srcFiles = dir(location{1});
    
    %On recup�re les images grd et rgb pour chaque dossier
    filename_grd = strcat('D:\bdfire_Red_1\', folders(i), '\', srcFiles(1).name);
    filename_rgb = strcat('D:\bdfire_Red_1\', folders(i), '\', srcFiles(2).name);
    
    tab_name_img{i} = srcFiles(2).name;
    
    %Nous allons d�finir les noms de l'images auxquels on va donner des F1
    %score
    row_header{i} = srcFiles(2).name;
    
    img_grd = imread(filename_grd{1});
    img_rgb = imread(filename_rgb{1});
    
    %puis on recup�re les caract�ristiques de l'image rgb
    [height, width, dim] = size(img_rgb);
    [f_img_predict] = get_caracteristic(img_rgb, 1, height, 1, width);
    f_img_predict = f_img_predict.';
    
    file_name = tab_name_img(i);
    %Si le model correspond ne correspond pas auxtrois meilleurs
    %SVM, on le prend pas en compte
    if index_f1_score ~= 1
        %On fait la pr�diction, pour chaque image
        [label_linear, score] = predict(SVMModel_linear, f_img_predict);
        hold off;
        label_linear = reshape(label_linear, [height, width]);
        f1_score_linear = get_f1_score(label_linear, img_grd);
        tab_f1_score_linear = [tab_f1_score_linear; f1_score_linear];
 
        subplot(1, 3, 1), imshow(label_linear); title('Image pr�dite'); 
        subplot(1, 3, 2), imshow(img_grd); title('Image groud truth'); 
        subplot(1, 3, 3), imshow(img_rgb); title('Image RGB');
        text(-2, -0.5, 'Lin�aire: comparaisons par rapport � l''image pr�dite', 'Units', 'normalized')
        repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\linear\', file_name{1});
        print(gcf, '-dpng', repertory);
        hold off;
        clf('reset')
    
    
    
%         %puis on fait l'affichage
%         imshow(label_linear); title('Lin�aire');
%         
%         %et on l'enregistre
%         file_name = strcat('img_predict_lineaire', num_img);
%         repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\linear\', file_name);
%         print(gcf, '-dpng', repertory);
%         hold off;
%         clf('reset')
    end
    
    %on fait de m�me pour les autres SVM
    if index_f1_score ~= 2
        [label_rbf, score_rbf] = predict(SVMModel_rbf, f_img_predict);
        label_rbf = reshape(label_rbf, [height, width]);
        
        f1_score_rbf = get_f1_score(label_rbf, img_grd);
        tab_f1_score_rbf = [tab_f1_score_rbf; f1_score_rbf];
    
        subplot(1, 3, 1), imshow(label_rbf); title('Image pr�dite'); 
        subplot(1, 3, 2), imshow(img_grd); title('Image groud truth'); 
        subplot(1, 3, 3), imshow(img_rgb); title('Image RGB');
        text(-2, -0.5, 'RBF: comparaisons par rapport � l''image pr�dite', 'Units', 'normalized')
        repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\rbf\', file_name{1});
        print(gcf, '-dpng', repertory);
        hold off;
        clf('reset')
        
        
%         imshow(label_rbf); title('RBF');
% 
%         file_name = strcat('img_predict_rbf', num_img);
%         repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\rbf\', file_name);
%         print(gcf, '-dpng', repertory);
%         hold off;
%         clf('reset')
    end
    
    if index_f1_score ~= 3
        [label_gauss, score_gauss] = predict(SVMModel_gauss, f_img_predict);
        label_gauss = reshape(label_gauss, [height, width]);
        
        f1_score_gauss = get_f1_score(label_gauss, img_grd);
        tab_f1_score_gauss = [tab_f1_score_gauss; f1_score_gauss];
        
        
        subplot(1, 3, 1), imshow(label_gauss); title('Image pr�dite'); 
        subplot(1, 3, 2), imshow(img_grd); title('Image groud truth'); 
        subplot(1, 3, 3), imshow(img_rgb); title('Image RGB');
        text(-2, -0.5, 'Gaussien: comparaisons par rapport � l''image pr�dite', 'Units', 'normalized')
        repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\gaussian\', file_name{1});
        print(gcf, '-dpng', repertory);
        hold off;
        clf('reset')
        
%         imshow(label_gauss); title('Gaussian');
% 
%         file_name = strcat('img_predict_gauss', num_img);
%         repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\gaussian\', file_name);
%         print(gcf, '-dpng', repertory);
%         hold off;
%         clf('reset')
    end
    
    if index_f1_score ~= 4
        [label_poly, score_poly] = predict(SVMModel_poly, f_img_predict);
        label_poly = reshape(label_poly, [height, width]);
        
        f1_score_poly = get_f1_score(label_poly, img_grd);
        tab_f1_score_poly = [tab_f1_score_poly; f1_score_poly];
        
        
        subplot(1, 3, 1), imshow(label_poly); title('Image pr�dite'); 
        subplot(1, 3, 2), imshow(img_grd); title('Image groud truth'); 
        subplot(1, 3, 3), imshow(img_rgb); title('Image RGB');
        text(-2, -0.9, 'Polynomial: comparaisons par rapport � l''image pr�dite', 'Units', 'normalized')
        repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\polynomial\', file_name{1});
        print(gcf, '-dpng', repertory);
        hold off;
        clf('reset')
        
%         imshow(label_poly); title('Polynomial');
% 
%         file_name = strcat('img_predict_poly', num_img);
%         repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Ann�e\Info 4007\tp\tp3\script\polynomial\', file_name);
%         print(gcf, '-dpng', repertory);
%         hold off;
%         clf('reset')
    end
end

%Sauvegarde fichier excel polynomial
col_header={'Noms image', 'F1_score'};
if index_f1_score ~= 1
    %Cr�ation du fichier excel lineaire
    xlswrite('f1_score_linear.xls',tab_f1_score_linear,'Sheet1','B2');
    xlswrite('f1_score_linear.xls',col_header,'Sheet1','B1');
    xlswrite('f1_score_linear.xls',row_header,'Sheet1','A2');
end

if index_f1_score ~= 2
    %Cr�ation du fichier excel rbf
    xlswrite('f1_score_rbf.xls',tab_f1_score_rbf,'Sheet1','B2');
    xlswrite('f1_score_rbf.xls',col_header,'Sheet1','A1');
    xlswrite('f1_score_rbf.xls',row_header,'Sheet1','A2');  
end

if index_f1_score ~= 3
    %Cr�ation du fichier excel gaussian
    xlswrite('f1_score_gauss.xls',tab_f1_score_gauss,'Sheet1','B2');
    xlswrite('f1_score_gauss.xls',col_header,'Sheet1','A1');
    xlswrite('f1_score_gauss.xls',row_header,'Sheet1','A2');  
end

if index_f1_score ~= 4
    %Cr�ation du fichier excel polynomial
    xlswrite('f1_score_poly.xls',tab_f1_score_poly,'Sheet1','B2');
    xlswrite('f1_score_poly.xls',col_header,'Sheet1','A1');
    xlswrite('f1_score_poly.xls',row_header,'Sheet1','A2');
end
%% 