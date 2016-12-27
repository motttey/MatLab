function matching_flag = machine_learning(DB, X, Qname, Method, feature)
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    init;
    switch Method
        case {'KNN','knn'}
            knn_pretreatment;
        case {'SVM','svm'}
            svm_pretreatment;
    end
    
    switch feature
        case {'HOG', 'hog'}
            Sample = extractHOGFeatures(X, 'CellSize', [16 16]);
        case {'LBP', 'lbp'}
            Sample = extractLBPFeatures(X, 'Upright', false);
        case {'DCT', 'dct'}
            dblX = double(X);
            dctX = dct2(dblX); %2éüå≥DCT
            dctXlow = dctX(1:6, 1:6); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
            Sample = reshape(dctXlow,1,36);
    end
    
    switch Method
        case {'KNN','knn'}
            faceClass = predict(Class,Sample);   
        case {'SVM','svm'}
            faceClass = predict(SVMClass,Sample);   
    end
     
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
