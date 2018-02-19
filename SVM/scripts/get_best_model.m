function [best_model, best_f1_score, ecart_type, best_BoxConstraint, best_KernelScale] = get_best_model(X, Y, type, folders)
    %on recupère le meilleur modèle, selon le type en variant C
    C = 1;
    best_f1_score = 0;
    tab_f1_score = [];
    
    if strcmp(type, 'linear') == 1
        cpt = 1;
    else
        cpt = 4;
    end
    
        SVMModel = fitcsvm(X, Y, 'KernelFunction', type, 'Standardize', true,'OptimizeHyperparameters','auto');

        %Pour les 10 images, on teste les modèles en modifiant le C
        for j = 1 : 10
            location=strcat('D:\bdfire_Red_1\', folders(j), '\*.png');
            srcFiles = dir(location{1});  % the folder in which ur images exists
            filename_grd = strcat('D:\bdfire_Red_1\', folders(j), '\', srcFiles(1).name);
            filename = strcat('D:\bdfire_Red_1\', folders(j), '\', srcFiles(2).name);
            img_grd = imread(filename_grd{1});
            img_test = imread(filename{1});
            [height, width, dim] = size(img_test);
            [f_img_test] = get_caracteristic(img_test, 1, height, 1, width);
            f_img_test = f_img_test.';


            [label, score] = predict(SVMModel, f_img_test);

            label = reshape(label, [height, width]);

            [f1_score] = get_f1_score(label, img_grd);
            tab_f1_score(j) = f1_score;            
        end
        avg_f1_score = mean(tab_f1_score);
        %Après avoir fait la moyenne, on cherche le meilleur SVM
        if avg_f1_score > best_f1_score
            best_f1_score = avg_f1_score;
            best_model = SVMModel;
            ecart_type = std(tab_f1_score);
            best_KernelScale = SVMModel.ModelParameters.KernelScale;
            best_BoxConstraint = SVMModel.ModelParameters.BoxConstraint;
        end
end