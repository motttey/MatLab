trainingFeatures = [];
trainingLabels   = [];
for k = 1:200
    quotient = floor((k - 1)/10);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(k) = PersonNum;
end
 for j = 1:200
    A = DB(:,:,j);
    
%     y = double(A);
%     [COEFF,SCORE,LATENT] = pca(y);
%     pca_Vector = COEFF(:,1);
%     Training(j,:) = pca_Vector;
    %[hog_8x8, vis8x8] = extractHOGFeatures(A,'CellSize',[8 8]);
    dblA = double(A);
    
    %8x8 35
    %4x4 39
    features(j, :) = extractHOGFeatures(A, 'CellSize', [4 4]);
    
    labels(j) = ceil(j/10);
    %Training(j,:) = dctAlowOneLine;
    %D = (dblX-dblA).^2;    
end
    trainingFeatures = [trainingFeatures; features];   %#ok<AGROW>
    trainingLabels   = [trainingLabels;   labels  ];   %#ok<AGROW>
    classifier = fitcecoc(trainingFeatures, trainingLabels);
    %Class = fitcknn(Training, group, 'NumNeighbors', 1);