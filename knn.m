function matching_flag = knn(Class, X, Qname)

    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    
%     dblX = double(X);
%     dctX = dct2(dblX); %2éüå≥DCT
%     dctXlow = dctX(1:5, 1:5); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
%     Sample = reshape(dctXlow,1,25);

    y = double(X);
    [COEFF,SCORE,LATENT] = pca(y);
    pca_Vector2 = COEFF(:,1); 
    
    faceClass = predict(Class, transpose(pca_Vector2));   
     
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (faceClass == Qname_num)
        match_seal = 'Åõ';
        matching_flag = 1;

    else
        match_seal = 'Å~';
        matching_flag = 0;

    end
    
    result = fprintf('%s is Persion %d %s \n',Qname, faceClass, match_seal);

end


