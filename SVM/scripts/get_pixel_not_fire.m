function[x_not_fire, y_not_fire] = get_pixel_not_fire(img)
%On recup�re les zones 10x10 o� il n'y a pas de feu
    [height, width, dim] = size(img);
    %On cherche les coordonn�es du centre
    x=abs((height)/2);
    y=abs((width)/2);
    cpt_not_fire = 0;
    x_not_fire = zeros(2, 3);
    y_not_fire = zeros(2, 3);
    x = round(x);
    y = round(y);
    %Tant qu'on a pas obtenu, trois r�gions non feu
    while cpt_not_fire < 3
        %On g�n�re des coordon��es al�atoires
        random_x = randi([-x x],1,1);
        random_y = randi([-y y],1,1);
        %On s'assure que si on rajoute les coordonn�es al�atoire au centre,
        %on aura une zone qui d�borde pas de la zone de feu
        if x + random_x > 0 && x + random_x + 9 > 0 && x + random_x < height && x + random_x + 9 < height && y + random_y > 0 && y + random_y + 10 > 0 && y + random_y < width && y + random_y + 10 < width
            pixel_is_black = img(x+random_x: x+random_x+9, y+random_y:y+random_y+9);
            %Si la zone est totalement non feu
             if isequal(pixel_is_black, zeros(10)) == 1
                %on enregistre les coordonn�es
                y_not_fire(1, cpt_not_fire+1)= y + random_y;
                y_not_fire(2, cpt_not_fire+1)= y + random_y +9;
                x_not_fire(1, cpt_not_fire+1)= x + random_x;
                x_not_fire(2, cpt_not_fire+1)= x + random_x +9;
                cpt_not_fire = cpt_not_fire + 1;
            end 
        end
    end
end