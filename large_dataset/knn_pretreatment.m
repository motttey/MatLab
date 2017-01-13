function Class = knn_pretreatment(DB, feature)
    init;
    for k = 1:DB_MAX
        quotient = floor((k - 1)/Individual_Face_Num);
        PersonNum = quotient + 1;
        str = strcat('Person: ', PersonNum);
        group(k) = PersonNum;
    end
     for j = 1:DB_MAX
        A = DB(:,:,j);

        switch feature
            case {'dct', 'DCT'}
                dblA = double(A);
                dctA = dct2(dblA); %2éüå≥DCT
                dctAlow = dctA(1:6, 1:6); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
                dctAlowOneLine= reshape(dctAlow,1,36);
                Training(j,:) = dctAlowOneLine;
            case {'hog', 'HOG'}
                Training(j,:) = extractHOGFeatures(A, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
            case {'LBP', 'lbp'}
                Training(j,:) = extractLBPFeatures(A, 'Upright', true);
            otherwise     
                dblA = double(A);
                dctA = dct2(dblA); %2éüå≥DCT
                dctAlow = dctA(1:6, 1:6); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
                dctAlowOneLine= reshape(dctAlow,1,36);
                Training(j,:) = dctAlowOneLine;        
        end
        %D = (dblX-dblA).^2;    
     end
    switch feature 
            case {'dct', 'DCT'}    
                Class = fitcknn(Training, group, 'NumNeighbors', 2);
            case {'hog', 'HOG'}    
                Class = fitcknn(Training, group, 'NumNeighbors', 2);
                Class.BreakTies = 'nearest';
                Class.IncludeTies = true;
                Class.Distance = 'correlation';
                Class.DistanceWeight = 'inverse';
            case {'LBP', 'lbp'}            
                Class = fitcknn(Training, group, 'NumNeighbors', 2);
    end
end