function index = pca_similarity2(DB, X, Qname)

    init;
    
    NN = 16;
    P_DB = zeros(DB_MAX, NN)
    P_Query = zeros(QUERY_MAX, NN)

    %Query_mean = X - ones(QUERY_MAX, 1)*mean(DB);
    DB_mean = DB - ones(DB_MAX, 1).*mean(DB);

    [U, R] = eigs(DB_mean'*DB_mean, NN);

    for i = 1:DB_MAX
        for j = 1:NN
            P_DB(i, j) = DB_mean(i, :)*U(:, j);
        end
    end
    for i = 1:QUERY_MAX
        for j = 1:NN
            P_Query(i, j) = Query_mean(i, :)*U(:, j);
        end
    end
    index = knnsearch(P_DB, P_Query, 'K', 5);

end