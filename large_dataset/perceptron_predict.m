
function matching_flag = perceptron_predict(net, X, Qname, Method, feature)
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    init;
    
    Sample = transpose(extractHOGFeatures(X, 'CellSize', [4 4]));
    %b = net.inputs{1}.size;
    face_sim = net(Sample);
    
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    
    if (face_sim == Qname_num)
        match_seal = 'Åõ';
        matching_flag = 1;

    else
        match_seal = 'Å~';
        matching_flag = 0;

    end
    
    result = fprintf('%s is Persion %d %s \n',Qname, face_sim, match_seal);

end
