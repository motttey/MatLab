
function matching_flag = neural_predict(net, X, Qname, network_name, neural_feature, isReject)
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    init;
    
    switch neural_feature
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
            Reshaped_X = reshape(X,1,Resize_Height * Resize_Width);
            Sample = double(Reshaped_X);
    end    
    %face_simi = net(Sample);
    face_simi = net(transpose(Sample));
    [maximum, index] = max(face_simi);   
    
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (maximum <= 0.3 && isReject == true)
            matching_flag = 3;  
            result = fprintf('%s is rejected\n', Qname);
    else
        if (index == Qname_num)
            match_seal = 'Åõ';
            matching_flag = 1;
        else
            match_seal = 'Å~';
            matching_flag = 0;

        end
        result = fprintf('%s is Persion %d %s \n',Qname, index, match_seal);
    end
    %train(net,transpose(Sample),face_simi); 
    
end
