function [vec_carac] = get_caracteristic(img, x1, x2, y1, y2)
    
    %Pour chaque canal, on extrait les coordonées corespondantes aux zones
    %passées en paramètrew
    R = img(:,:,1);
    r = R(x1:x2, y1:y2);
    G = img(:,:,2);
    g = G(x1:x2, y1:y2);
    B = img(:,:,3);
    b = B(x1:x2, y1:y2);
 
    Rn = R ./ (R + G + B);
    rn = Rn(x1:x2, y1:y2);
    Gn = G ./ (R + G + B);
    gn = Gn(x1:x2, y1:y2);
    
    YCBCR = rgb2ycbcr(img);
    Y= YCBCR (:,:,1);
    y = Y(x1:x2, y1:y2);
    Cb= YCBCR (:,:,2);
    cb = Cb(x1:x2, y1:y2);
    Cr= YCBCR (:,:,3);
    cr = Cr(x1:x2, y1:y2);
    
    HSV = rgb2hsv(img);
    H= HSV(:,:,1); 
    h = H(x1:x2, y1:y2);
    S= HSV(:,:,2);
    s = S(x1:x2, y1:y2);
    V= HSV(:,:,3);
    v = V(x1:x2, y1:y2);
    
    YIQ = rgb2ntsc(img);
    I= YIQ(:,:,2);
    i = I(x1:x2, y1:y2);
    Q= YIQ(:,:,3);
    q = Q(x1:x2, y1:y2);
    
    LAB = rgb2lab(img);
    L=LAB(:,:,1); 
    l = L(x1:x2, y1:y2);
    A= LAB (:,:,2);
    a = A(x1:x2, y1:y2);
    B= LAB (:,:,3);
    b_lab = B(x1:x2, y1:y2);
 
    [height, width, dim] = size(r);
    
    %Puis on fait un reshape pour ordonner les pixels selon leur numéro
    r = reshape(r, [1, height * width]);
    g = reshape(g, [1, height * width]);
    b = reshape(b, [1, height * width]);
    rn = reshape(rn, [1, height * width]);
    gn = reshape(gn, [1, height * width]);
    y = reshape(y, [1, height * width]);
    cb = reshape(cb, [1, height * width]);
    cr = reshape(cr, [1, height * width]);
    l = reshape(l, [1, height * width]);
    a = reshape(a, [1, height * width]);
    b_lab = reshape(b_lab, [1, height * width]);
    h = reshape(h, [1, height * width]);
    s = reshape(s, [1, height * width]);
    v = reshape(v, [1, height * width]);
    i = reshape(i, [1, height * width]);
    q = reshape(q, [1, height * width]);
    
    vec_carac = [double(r); double(g); double(b); double(rn); double(gn); double(y); double(cb); double(cr); double(l); double(a); double(b_lab); double(h); double(s); double(v); double(i); double(q)];  
end