function matching_flag = knn(Class, X, Qname)
    
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    
    dblX = double(X);
    dctX = dct2(dblX); %2ŸŒ³DCT
    dctXlow = dctX(1:6, 1:6); %DCT’áˆæ¬•ª‚Ìæ‚èo‚µ
    Sample = reshape(dctXlow,1,36);
    
     faceClass = predict(Class,Sample);   
     
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (faceClass == Qname_num)
        match_seal = '›';
        matching_flag = 1;

    else
        match_seal = '~';
        matching_flag = 0;

    end
    
    result = fprintf('%s is Persion %d %s \n',Qname, faceClass, match_seal);

end


