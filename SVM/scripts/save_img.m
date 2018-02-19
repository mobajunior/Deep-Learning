function save_img(img, x_fire, y_fire, file_name)
    %Pour chaque espace de couleur, on sauvegarde l'image des zones de feux
    mkdir ../script RGB
    mkdir ../script HSV
    mkdir ../script YCBCR
    mkdir ../script YIQ
    mkdir ../script LAB
    RGB = img;
    HSV = rgb2hsv(img);
    YCBCR = rgb2ycbcr(img);
    YIQ = rgb2ntsc(img);
    LAB = rgb2lab(img);
     
        regions_RGB1 = RGB(x_fire(1, 1):x_fire(2, 1), y_fire(1, 1): y_fire(2, 1),:);
        regions_RGB2 = RGB(x_fire(1, 2):x_fire(2, 2), y_fire(1, 2): y_fire(2, 2),:);
        regions_RGB3 = RGB(x_fire(1, 3):x_fire(2, 3), y_fire(1, 3): y_fire(2, 3),:);
        
        regions_HSV1 = HSV(x_fire(1, 1):x_fire(2, 1), y_fire(1, 1): y_fire(2, 1),:);
        regions_HSV2 = HSV(x_fire(1, 2):x_fire(2, 2), y_fire(1, 2): y_fire(2, 2),:);
        regions_HSV3 = HSV(x_fire(1, 3):x_fire(2, 3), y_fire(1, 3): y_fire(2, 3),:);
        
        regions_YCBCR1 = YCBCR(x_fire(1, 1):x_fire(2, 1), y_fire(1, 1): y_fire(2, 1),:);
        regions_YCBCR2 = YCBCR(x_fire(1, 2):x_fire(2, 2), y_fire(1, 2): y_fire(2, 2),:);
        regions_YCBCR3 = YCBCR(x_fire(1, 3):x_fire(2, 3), y_fire(1, 3): y_fire(2, 3),:);
        
        regions_YIQ1 = YIQ(x_fire(1, 1):x_fire(2, 1), y_fire(1, 1): y_fire(2, 1),:);
        regions_YIQ2 = YIQ(x_fire(1, 2):x_fire(2, 2), y_fire(1, 2): y_fire(2, 2),:);
        regions_YIQ3 = YIQ(x_fire(1, 3):x_fire(2, 3), y_fire(1, 3): y_fire(2, 3),:);
        
        regions_LAB1 = LAB(x_fire(1, 1):x_fire(2, 1), y_fire(1, 1): y_fire(2, 1),:);
        regions_LAB2 = LAB(x_fire(1, 2):x_fire(2, 2), y_fire(1, 2): y_fire(2, 2),:);
        regions_LAB3 = LAB(x_fire(1, 3):x_fire(2, 3), y_fire(1, 3): y_fire(2, 3),:);


    matrice_region = [regions_RGB1; regions_RGB2; regions_RGB3]; 
    subplot(1,4,1), imshow(regions_RGB1); title('zone1'); 
    subplot(1,4,2), imshow(regions_RGB2); title('zone2');
    subplot(1,4,3), imshow(regions_RGB3); title('zone3');  
    subplot(1,4,4), imshow(matrice_region); title('zone superposees'); 
    text(-0.2, -0.5, 'RGB', 'Units', 'normalized')
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Année\Info 4007\tp\tp3\script\RGB\', file_name);
    print(gcf, '-dpng', repertory);
    hold off;
    clf('reset')
    
    matrice_region = [regions_HSV1; regions_HSV2; regions_HSV3];
    subplot(1,4,1), imshow(regions_HSV1); title('zone1'); 
    subplot(1,4,2), imshow(regions_HSV2); title('zone2'); 
    subplot(1,4,3), imshow(regions_HSV3); title('zone3'); 
    subplot(1,4,4), imshow(matrice_region); title('zone superposees');
    text(-0.2, -0.5, 'HSV',                 'Units', 'normalized')
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Année\Info 4007\tp\tp3\script\HSV\', file_name);
    print(gcf, '-dpng', repertory);
    hold off;
    clf('reset')
    
    matrice_region = [regions_YCBCR1; regions_YCBCR2; regions_YCBCR3];
    subplot(1,4,1), imshow(regions_YCBCR1); title('zone1');
    subplot(1,4,2), imshow(regions_YCBCR2); title('zone2'); 
    subplot(1,4,3), imshow(regions_YCBCR3); title('zone3'); 
    subplot(1,4,4), imshow(matrice_region); title('zone superposees');
    text(-0.2, -0.5, 'YCBCR', 'Units', 'normalized')
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Année\Info 4007\tp\tp3\script\YCBCR\', file_name);
    print(gcf, '-dpng', repertory);
    hold off;
    clf('reset')
    
    matrice_region = [regions_YIQ1; regions_YIQ2; regions_YIQ3];
    subplot(1,4,1), imshow(regions_YIQ1); title('zone1'); 
    subplot(1,4,2), imshow(regions_YIQ2); title('zone2');
    subplot(1,4,3), imshow(regions_YIQ3); title('zone3'); 
    subplot(1,4,4), imshow(matrice_region); title('zone superposees');
    text(-0.2, -0.5, 'YIQ', 'Units', 'normalized')
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Année\Info 4007\tp\tp3\script\YIQ\', file_name);
    print(gcf, '-dpng', repertory);
    hold off;
    clf('reset')
    
    matrice_region = [regions_LAB1; regions_LAB2; regions_LAB3];
    subplot(1, 4, 1), imshow(regions_LAB1); title('zone1'); 
    subplot(1, 4, 2), imshow(regions_LAB2); title('zone2'); 
    subplot(1, 4, 3), imshow(regions_LAB3); title('zone3');
    subplot(1, 4, 4), imshow(matrice_region); title('zone superposees');
    text(-0.2, -0.5, 'LAB', 'Units', 'normalized')
    repertory = strcat('C:\Users\Moussa BA\Dropbox\4ieme Année\Info 4007\tp\tp3\script\LAB\', file_name);
    print(gcf, '-dpng', repertory);
    hold off;
    clf('reset')
end