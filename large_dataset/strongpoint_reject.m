function match_points = strongpoint_reject(X, A)
    dblX = double(X);
    boxPoints = detectSURFFeatures(X);
        
    dblA = double(A);   
    scenePoints = detectSURFFeatures(A);

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
        
    match_points = m;
end

