function matching_flag = matching(DB, X, Qname, Method)
    %Ratio num/55
    %dblX = double(X);
    init;
    %flags
    doMatching = true;
    %äeì¡í•ó , óﬁéóìxåvéZéËñ@
    switch Method
        case {'zncc','ZNCC'}
            index = zncc(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case {'ncc','NCC'}
            index = ncc(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case {'poc','POC'}
            index = POC_Similarity(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case {'edge','EDGE'}
            index = edge_similarity(DB, X, Qname);        
            number=ceil(index/Individual_Face_Num);
        case {'dct','DCT'}
            index = dct_similarity(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case {'pca','PCA'}
            index = pca_similarity(DB, X, Qname);
            number = index;
        case {'hist','histgram', 'HIST'}
            index = hist_similarity(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case 'strong_point'
            index = strong_point2(DB, X, Qname);
            number=ceil(index/Individual_Face_Num);
        case ''
%             if doMatching == true
%                 fprintf('input method name is null!\n');
%             end
            doMatching = false;
        otherwise 
%             if doMatching == true
%                 fprintf('input method name is wrong!\n');
%             end
            doMatching = false;
    end
    
    %ê≥åÎîªíË
    if doMatching == true
        Qname_token = strtok(Qname, 'q');
        Qname_num = str2num(Qname_token) + 1;
        
        if (number == Qname_num)
            match_seal = 'Åõ';
            matching_flag = 1;

        else
            match_seal = 'Å~';
            matching_flag = 0;
        end
        result = fprintf('%s is Persion %d %s \n',Qname, number, match_seal);       
    else
            matching_flag = 2;        
    end
end