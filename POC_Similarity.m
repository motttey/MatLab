function index = POC_similarity(DB, X, Qname)

    for i=1:200;
            A = DB(:,:,i);
            edgeA = edge(A, 'Canny');
            edgeAdbl = double(edgeA);
            P = poc(edgeAdbl, edgeXdbl);
            distance(i) = max(max(P));        
    end
    
    [maximum, index] = max(distance);
    
end