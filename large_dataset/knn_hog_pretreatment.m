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
   
     Training(j,:) = extractHOGFeatures(A, 'CellSize', [4 4]);
    %D = (dblX-dblA).^2;    
end

     Class = fitcknn(Training, group, 'NumNeighbors', 2);