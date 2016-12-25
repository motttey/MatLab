function index = edge_similarity(DB, X, Qname)
 %edge + histeq 17
 %edge: 15
 
     edgeX = edge(X, 'sobel');
     edgeXdbl = double(edgeX);
     for i = 1:DB_MAX
         A = DB(:,:,i);
         edgeA = edge(A, 'sobel');
         edgeAdbl = double(edgeA);
         D = (edgeXdbl-edgeAdbl).^2;
         distance(i) = sum(sum(D));
     end
     [minimum, index] = min(distance);
end
