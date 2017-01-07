
function matching_flag = patternnet_predict(net, X, Qname, Method, feature)
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    init;
    
    %Reshaped_X = double(reshape(X, 1, Resize_Height * Resize_Width));
    %Sample = transpose(Reshaped_X);

    Sample = extractHOGFeatures(X, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
    %b = net.inputs{1}.size;
    %face_simi = net(Sample);
    face_simi = net(transpose(Sample));
    [maximum, index] = max(face_simi);   
    
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (index == Qname_num)
        match_seal = 'Åõ';
        matching_flag = 1;

    else
        match_seal = 'Å~';
        matching_flag = 0;

    end
    
    %train(net,transpose(Sample),face_simi); 
    
    result = fprintf('%s is Persion %d %s \n',Qname, index, match_seal);

end
