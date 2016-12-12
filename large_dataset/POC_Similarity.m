function index = POC_similarity(DB, X, Qname)
    dblX = double(X);
    edgeXdbl = edge(dblX, 'Canny');
    for i=1:695;
            A = DB(:,:,i);
            edgeA = edge(A, 'Canny');
            edgeAdbl = double(edgeA);
            P = poc(edgeAdbl, edgeXdbl);
            distance(i) = max(max(P));        
    end
    
    [maximum, index] = max(distance);
    
end