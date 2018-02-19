function[x_fire, y_fire] = get_pixel_fire(img)
%on recherche 3 zones de feu de 10x10px
    [row, column] = find(img == 1);
    if row(1) < row(end)
        x1 = row(1);
        x2 =row(end);
    else
        x2 = row(1);
        x1 =row(end);
    end
    
    if column(1) < column(end)
        y1 = column(1);
        y2 = column(end);
    else
        y2 = column(1);
        y1 =column(end);
    end
    
    cpt_fire = 0;
    %On cherche le centre de la zone de feu
    x=abs((x1+x2)/2);
    y=abs((y1+y2)/2);
    
    %variables définies pour stocker les 3 zones de feu
    y_fire = zeros(2, 3);
    x_fire = zeros(2, 3);
    x = round(x);
    y = round(y);

    %tant qu'on a pas obtenu trois zones de feu
    while cpt_fire < 3
        %On cheche des coordonnées aléatoires comprises dans la zone de feu
        random_x = randi([-x x],1,1);
        random_y = randi([-y y],1,1);
        %on teste si on rajoute les coordonnées aléatoires au centre, s'il
        %ne vont pas déborder de la zone de feu
        if x + random_x > x1 && x + random_x < x2 && y + random_y > y1 && y + random_y < y2 && x + random_x +10 > x1 && x + random_x +10 < x2 && y + random_y + 10 > y1 && y + random_y + 10 < y2 
            region1 = img(x+random_x: x+random_x+9, y+random_y:y+random_y+9);
            %Si oui on regarde si la zone prise va être totalement feu
            if isequal(region1, ones(10)) == 1
                %Et on enregistre les coordonnées
                y_fire(1,cpt_fire+1)=y + random_y;
                y_fire(2,cpt_fire+1)=y + random_y +9;
                x_fire(1,cpt_fire+1)=x + random_x;
                x_fire(2,cpt_fire+1)=x + random_x +9;
                cpt_fire = cpt_fire + 1;
            end
        end
    end
end