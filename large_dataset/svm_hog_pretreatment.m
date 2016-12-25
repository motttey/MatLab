init; 
for i = 1:DB_MAX
    quotient = floor((i - 1)/35);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(i) = PersonNum;
end
%
% Indices = crossvalind('Kfold', DB_MAX, group)
 for j = 1:DB_MAX
    A = DB(:,:,j);
   
    Training(j,:) = extractHOGFeatures(A, 'CellSize', [16 16]);
 end
 t = templateSVM('Standardize',1, 'KernelFunction', 'linear', 'Solver','ISDA');
 SVMClass = fitcecoc(Training, group, 'Learners', t);
 
 %SVMClass = fitcecoc(Training, group, 'Learners', 'svm', 'FitPosterior', 'off',...
 %'KernelFunction', 'linear',...
 %'ClassNames',{'1','2','3','4','5','6','7','8','9','10','11','12', '13','14','15','16','17','18','19','20'});