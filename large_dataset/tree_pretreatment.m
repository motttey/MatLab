function tree = tree_pretreatment(DB, tree_name, tree_feature)
    init;
    for k = 1:DB_MAX
        quotient = floor((k - 1)/Individual_Face_Num);
        PersonNum = quotient + 1;
        group(k) = PersonNum;
    end
    
    for j = 1:DB_MAX
        A = DB(:,:,j);
        switch tree_feature
            case {'dct', 'DCT'}
                dblA = double(A);
                dctA = dct2(dblA); %2����DCT
                dctAlow = dctA(1:DCT_Size, 1:DCT_Size); %DCT��搬���̎��o��
                dctAlowOneLine= reshape(dctAlow,1,DCT_Size^2);
                Training(j,:) = dctAlowOneLine;
            case {'hog', 'HOG'}
                Training(j,:) = extractHOGFeatures(A, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
            case {'LBP', 'lbp'}
                Training(j,:) = extractLBPFeatures(A, 'Upright', true);
            otherwise     
                dblA = double(A);
                dctA = dct2(dblA); %2����DCT
                dctAlow = dctA(1:DCT_Size, 1:DCT_Size); %DCT��搬���̎��o��
                dctAlowOneLine= reshape(dctAlow,1,DCT_Size);
                Training(j,:) = dctAlowOneLine;        
        end
        %D = (dblX-dblA).^2;    
    end

    switch tree_name
        case 'normal'
            tree = fitctree(Training,group);
        case 'bagger'
            tree = TreeBagger(200, Training, group, 'Method','classification','NumPredictorsToSample', 50,...
            'Prior', 'Uniform');
        case 'ada'
            tree = fitensemble(Training, group, 'LPBoost', 200, 'Tree');
        otherwise
    end
    
end