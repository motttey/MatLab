function matching_flag = svm_hog(SVMClass, X, Qname)

    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    

    Sample = extractHOGFeatures(X, 'CellSize', [16 16]);

%     y = double(X);
%     [COEFF,SCORE,LATENT] = pca(y);
%     pca_Vector2 = COEFF(:,1); 
    %[n,d]=knnsearch(Training(1,:),Sample,'k',10,'distance','minkowski','p',5);
    
    [faceClass score cost]  = predict(SVMClass, Sample);   
    score_num = 0;
    for i = 1:length(score)
        if score(i) ~= 0
            score_num = score_num + 1;
        end
    end
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    faceClassNum = faceClass;
    %faceClassNum = str2num(cell2mat(faceClass));

    if (faceClassNum == Qname_num)
        match_seal = 'Åõ';
        matching_flag = 1;

    else
        match_seal = 'Å~';
        matching_flag = 0;

    end
    
     result = fprintf('%s is Persion %d %s \n',Qname, faceClassNum, match_seal);

end