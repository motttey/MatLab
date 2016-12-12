function matching_flag = matching(DB, X, Qname)
    
    %Ratio num/55
    %dblX = double(X);
    
    %各特徴量, 類似度計算手法
    index = zncc(DB, X, Qname);
    index = ncc(DB, X, Qname);
    index = POC_similarity(DB, X, Qname);
    index = edge_similarity(DB, X, Qname);
    index = dct_similarity(DB, X, Qname);
    index = hist_similarity(DB, X, Qname);
    %distance

    %figure
    %A=DB
    %imshow(A)

    number = ceil(index/10);
    %fprintf(' is Person %d.\n', number)
    
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    number=ceil(index/10);
    
    if (number == Qname_num)
        match_seal = '○';
        matching_flag = 1;

    else
        match_seal = '×';
        matching_flag = 0;

    end
          
    result = fprintf('%s is Persion %d %s \n',Qname, number, match_seal);   
end

