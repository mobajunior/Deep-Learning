matrix = load('ORL_64x64.mat');
fea = matrix.fea;
size(fea);
current_folder = 'C:\Users\mb\vgg\db';
mkdir img_0;
mkdir img_90;
mkdir img_180;
mkdir img_270;

for i = 1 : 400
   num_img = num2str(i);
   file_name = strcat('img_', num_img, '_0deg.png');
   file_name_90 = strcat('img_', num_img, '_90deg.png');
   file_name_180 = strcat('img_', num_img, '_180deg.png');
   file_name_270 = strcat('img_', num_img, '_270deg.png');
   img_64 = fea(i, :);
   img_64 = reshape(img_64, [64, 64]);
   img = imresize(img_64,[224 224]);
   %Obtention des images selon leurs différents angles
   grayImage= mat2gray(img);
   img_0 = cat(3, grayImage, grayImage, grayImage);
   img_90 = imrotate(img_0, 90);
   img_180 = imrotate(img_0, 180);
   img_270 = imrotate(img_0, 270);
   
   
   %Sauvegarde des images d'angle 0
   path_img = strcat(current_folder, '\img_0\', file_name);
   imwrite(img_0, path_img);
   %Sauvegarde des images d'angle 90
   path_img = strcat(current_folder, '\img_90\', file_name_90);
   imwrite(img_90, path_img);
   %Sauvegarde des images d'angle 180
   path_img = strcat(current_folder, '\img_180\', file_name_180);
   imwrite(img_180, path_img);
   %Sauvegarde des images d'angle 270
   path_img = strcat(current_folder, '\img_270\', file_name_270);
   imwrite(img_270, path_img);
end
% for i = 1 : (400/64) 
%   for j = 1 : 64
%     img = fea(i : i*64, j*64);
%   end
% end
