function index = strong_point2(DB, X, Qname)
    init;
    %Ratio num/55
    intX = uint8(X);
    
    boxPoints = detectSURFFeatures(intX);
    
    for i = 1:DB_MAX
        
        A = DB(:,:,i);
        intA = uint8(A);   
                
        scenePoints = detectSURFFeatures(intA);

        [boxFeatures, boxPoints] = extractFeatures(intX, boxPoints);
        [sceneFeatures, scenePoints] = extractFeatures(intA, scenePoints);

        boxPairs = matchFeatures(boxFeatures, sceneFeatures);

        matchedBoxPoints = boxPoints(boxPairs(:, 1), :);

        [m, n] = size(matchedBoxPoints);

        match_points = m;
        distance(i) = match_points;
    end
    
    [maximum, index] = max(distance);
    fprintf('%d ',maximum);   
end
    
%     
    %distance
    %figure
    %A=DB
    %imshow(A)