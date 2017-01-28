function index = dct_similarity(DB, X, Qname)
    init;
    
    %DCT + histeq 32
    %DCT: Score 30

    dblX = double(X);
    dctX = dct2(dblX); %2ŸŒ³DCT
    dctXlow = dctX(1:10, 1:10); %DCT’áˆæ¬•ª‚Ìæ‚èo‚µ
    for i = 1:DB_MAX
        A = DB(:,:,i);
        dblA = double(A);
        dctA = dct2(dblA); %2ŸŒ³DCT
        dctAlow = dctA(1:10, 1:10); %DCT’áˆæ¬•ª‚Ìæ‚èo‚µ
        %D = (dblX-dblA).^2;
        D = (dctXlow-dctAlow).^2;
        distance(i) = sum(sum(D));
    end
    [minimum, index] = min(distance);

end