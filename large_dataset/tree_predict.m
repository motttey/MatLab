
function matching_flag = tree_predict(tree, X, Qname, tree_name, tree_feature)
    init;
    
    switch tree_feature
        case {'plane'}
            Reshaped_X = reshape(X,1,Resize_Height * Resize_Width);
            Sample = double(Reshaped_X);
        case {'hog', 'HOG'}
            Sample = extractHOGFeatures(X, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
        case {'LBP', 'lbp'}
            Sample = extractLBPFeatures(X, 'Upright', true);
        case {'DCT', 'dct'}
            dblX = double(X);
            dctX = dct2(dblX); %2éüå≥DCT
            dctXlow = dctX(1:DCT_Size, 1:DCT_Size); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
            Sample = reshape(dctXlow,1,DCT_Size^2);
        otherwise     
            dblA = double(A);
            dctA = dct2(dblA); %2éüå≥DCT
            dctAlow = dctA(1:DCT_Size, 1:DCT_Size); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
            dctAlowOneLine= reshape(dctAlow,1,DCT_Size);
            Training(j,:) = dctAlowOneLine;     
    end
    
    switch tree_name
        case 'normal'
            index = predict(tree,Sample);
        case 'bagger'
            index = str2num(char(predict(tree,Sample)));
        case 'ada'
            index = predict(tree,Sample);
        otherwise
            index = predict(tree,Sample);
    end
        
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (index == Qname_num)
        match_seal = 'Åõ';
        matching_flag = 1;

    else
        match_seal = 'Å~';
        matching_flag = 0;

    end
        
    result = fprintf('%s is Persion %d %s \n',Qname, index, match_seal);

end
