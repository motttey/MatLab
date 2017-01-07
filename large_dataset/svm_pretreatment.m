function SVMClass = svm_pretreatment(DB, feature)
    init;
    for i = 1:DB_MAX
        quotient = floor((i - 1)/Individual_Face_Num);
        PersonNum = quotient + 1;
        str = strcat('Person: ', PersonNum);
        group(i) = PersonNum;
    end
    %
    % Indices = crossvalind('Kfold', DB_MAX, group)
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
                    Training(j,:) = extractLBPFeatures(X, 'Upright', false);
                otherwise     
                    dblA = double(A);
                    dctA = dct2(dblA); %2éüå≥DCT
                    dctAlow = dctA(1:6, 1:6); %DCTí·àÊê¨ï™ÇÃéÊÇËèoÇµ
                    dctAlowOneLine= reshape(dctAlow,1,36);
                    Training(j,:) = dctAlowOneLine;       
        end
    end

     switch feature
            case {'dct', 'DCT'}
                 t = templateSVM('Standardize',1, 'KernelFunction', 'linear', 'Solver','ISDA');
                 SVMClass = fitcecoc(Training, group, 'Learners', t);
            case {'hog', 'HOG'}
                 t = templateSVM('Standardize',1, 'KernelFunction', 'linear', 'Solver','ISDA');
                 SVMClass = fitcecoc(Training, group, 'Learners', t);
            case {'LBP', 'lbp'}
                 t = templateSVM('Standardize',1, 'KernelFunction', 'linear', 'Solver','ISDA');
                 SVMClass = fitcecoc(Training, group, 'Learners', t);
     end

     %SVMClass = fitcecoc(Training, group, 'Learners', 'svm', 'FitPosterior', 'off',...
     %'KernelFunction', 'linear',...
     %'ClassNames',{'1','2','3','4','5','6','7','8','9','10','11','12', '13','14','15','16','17','18','19','20'});
     
end