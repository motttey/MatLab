init; 
for k = 1:DB_MAX
    quotient = floor((k - 1)/35);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(k) = PersonNum;
end
 for j = 1:DB_MAX
    A = DB(:,:,j);
   
     Training(j,:) = extractLBPFeatures(A,'Upright',false);
end

LBPClass = fitcknn(Training, group, 'NumNeighbors', 2);