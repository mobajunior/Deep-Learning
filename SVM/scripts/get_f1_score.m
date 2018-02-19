function [value] = get_f1_score(img_predict, img_true)
    %Calcul du F1 score pour chaque image
    %On recupère la zone d'intercion de l'image prédite et de la vraie
    %image en faisant un AND
    Anded_image = img_predict & img_true;
    TP = sum(sum(Anded_image));
    
    %Puis FN, en faisant un xor entre la vraie image et de l'Anded_image
    FN = xor(img_true, Anded_image);
    FN = sum(sum(FN));
    
    %et FP, en faisant un xor entre l'image prédite et de l'Anded_image
    FP = xor(img_predict, Anded_image);
    FP = sum(sum(FP));
    
    P = TP / (TP + FP);
    R = TP / (TP +FN);
    
    value =  2 * (P * R) / (P + R);
    
end