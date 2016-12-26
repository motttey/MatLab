function index = strong_point2(DB, X, Qname)
    init;
    %Ratio num/55
    dblX = double(X);
    
    boxPoints = detectSURFFeatures(X);
    
    for i = 1:DB_MAX
        
        A = DB(:,:,i);
        dblA = double(A);   
        
        scenePoints = detectSURFFeatures(A);
        
%         figure;
%         imshow(X);
%         title('100 Strongest Feature Points from Box Image');
%         hold on;
%         plot(selectStrongest(boxPoints, 100));
        
%         figure;
%         imshow(A);
%         title('300 Strongest Feature Points from Scene Image');
%         hold on;
%         plot(selectStrongest(scenePoints, 300));
        
        [boxFeatures, boxPoints] = extractFeatures(X, boxPoints);
        [sceneFeatures, scenePoints] = extractFeatures(A, scenePoints);
        
        boxPairs = matchFeatures(boxFeatures, sceneFeatures);
        
        matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
        matchedScenePoints = scenePoints(boxPairs(:, 2), :);
        
%         figure;
%         showMatchedFeatures(X, A, matchedBoxPoints, ...
%             matchedScenePoints, 'montage');
%         title('Putatively Matched Points (Including Outliers)');

% %         [tform, inlierBoxPoints, inlierScenePoints] = estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');     
        [m, n] = size(matchedBoxPoints);
        
        distance(i) = m;
        
    end
    
%     
    %distance
    [maximum, index] = max(distance);
    fprintf('%d ',maximum);
    %figure
    %A=DB
    %imshow(A)