function matching_flag = machine_learning(DB, X, Qname, Method, feature, Class)
    %flag = matching(DB, X, listing(i).name);
    init;
    
    switch feature
        case {'HOG', 'hog'}
            Sample = extractHOGFeatures(X, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
        case {'LBP', 'lbp'}
            Sample = extractLBPFeatures(X, 'Upright', true);
        case {'DCT', 'dct'}
            dblX = double(X);
            dctX = dct2(dblX); %2次元DCT
            dctXlow = dctX(1:6, 1:6); %DCT低域成分の取り出し
            Sample = reshape(dctXlow,1,36);
        otherwise     
            dblX = double(X);
            dctX = dct2(dblX); %2次元DCT
            dctXlow = dctX(1:6, 1:6); %DCT低域成分の取り出し
            Sample = reshape(dctXlow,1,36);
    end
    
    switch Method
        case {'KNN','knn'}
            [faceClass, score] = predict(Class,Sample);   
        case {'SVM','svm'}
            faceClass = predict(Class,Sample);   
    end
     
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (faceClass == Qname_num)
        match_seal = '○';
        matching_flag = 1;

    else
        match_seal = '×';
        matching_flag = 0;

    end
    
    result = fprintf('%s is Persion %d %s \n',Qname, faceClass, match_seal);

end
