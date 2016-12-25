function index = strong_point(DB, X, Qname)
    
    %Ratio num/55
    dblX = double(X);
    
    boxPoints = detectSURFFeatures(X);
    
    for i = 1:665
        
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
        
        distance(i) = 0;
        if m ~= 0
           for j=1:m
                distance(i) = distance(i) + abs(matchedBoxPoints.Location(j,1)-matchedScenePoints.Location(j,1)).^2 + abs(matchedBoxPoints.Location(j,2)-matchedScenePoints.Location(j,2)).^2;
            end
            distance(i) = distance(i)/m;
        else
            distance(i) = 100000;
        end
        
    end
    
%     
    %distance
    [minimum, index] = min(distance);

    %figure
    %A=DB
    %imshow(A)