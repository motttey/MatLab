function matching_flag = hog(classifier, X, Qname)

    %fprintf('%d', i)

%     y = double(X);
%     [COEFF,SCORE,LATENT] = pca(y);
%     pca_Vector2 = COEFF(:,1); 
    Sample = extractHOGFeatures(X, 'CellSize', [4 4]);

    faceClass = predict(classifier, Sample);   
     
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
