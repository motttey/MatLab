init; 
for k = 1:DB_MAX
    quotient = floor((k - 1)/35);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(k) = PersonNum;
end
 for j = 1:DB_MAX
    A = DB(:,:,j);
   
     Training(j,:) = extractHOGFeatures(A, 'CellSize', [16 16]);
end

Class = fitcknn(Training, group, 'NumNeighbors', 2, 'IncludeTies', false);
Class.BreakTies = 'nearest';
Class.Distance = 'euclidean';
Class.DistanceWeight = 'inverse';