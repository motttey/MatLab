function index = hist_similarity(DB, X, Qname)

    %Histgram Intersection 22
    %Histgram Intersection + histeq 12
    %hist: Score 1
    %hist + histeq 7
    Histgram_Length = 256;
    X1 = X(:);
    dblX = double(X1);
    histX = hist(dblX, 256); %ヒストグラム
   
    
    for i = 1:DB_MAX
            A = DB(:,:,i);
            A1 = A(:);
            %1次元化
            dblA = double(A1);
            histA = hist(dblA, 256);%ヒストグラム
            histsum = 0;
            histAsum = 0;
        for j = 1:Histgram_Length
            histsum = histsum + max(histA(j),histX(j));
            histAsum = histAsum + histA(j);
            %D = (histX-histA).^2;
        end
            Similar_degrees = histsum/ histAsum;
            distance(i) = abs(1 - Similar_degrees) ;    
    end
    %[minimum, index] = min(distance);

end