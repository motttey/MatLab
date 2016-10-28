 for k = 1:200
    quotient = floor((k - 1)/10);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(k) = PersonNum;
end
 for j = 1:200
    A = DB(:,:,j);
    dblA = double(A);
    dctA = dct2(dblA); %2ŸŒ³DCT
    dctAlow = dctA(1:6, 1:6); %DCT’áˆæ¬•ª‚Ìæ‚èo‚µ
    dctAlowOneLine= reshape(dctAlow,1,36);
    Training(j,:) = dctAlowOneLine;
    %D = (dblX-dblA).^2;    
end

     Class = fitcknn(Training, group, 'NumNeighbors', 3);