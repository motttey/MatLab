
function matching_flag = perceptron_predict(net, X, Qname, Method, feature)
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    init;
    
    Sample = extractHOGFeatures(X, 'CellSize', [2 2]);
    %b = net.inputs{1}.size;
    %face_simi = net(Sample);
    face_simi = sim(net,transpose(Sample)) ;
    
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
    
    result = fprintf('%s is Persion %d %s \n',Qname, index, match_seal);

end
