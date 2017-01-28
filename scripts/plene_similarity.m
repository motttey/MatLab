function index = plene_similarity(DB, X, Qname)
    init;

    dblX = double(X);
    for i = 1:DB_MAX
        A = DB(:,:,i);
        dblA = double(A);
        D = (dblX-dblA).^2;
        distance(i) = sum(sum(D));
    end
    [minimum, index] = min(distance);

end