detector = vision.CascadeObjectDetector(); % �猟�o�I�u�W�F�N�g��`

%dbgen_hist
%querygen_hist
% 
dbgenb
querygenb

 matching_num = 0;
 
knn_pretreatment
tic;
for i = 1:58
    X=Query(:,:,i);
    %fprintf('%d', i)
    %flag = pca_similarity(DB, X, listing(i).name);
    flag = knn(Class, X, listing(i).name);

    if flag == 1
        matching_num = matching_num + 1;
    end
end
toc;
fprintf('matching_num %d \n', matching_num);