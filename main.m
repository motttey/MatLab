detector = vision.CascadeObjectDetector(); % 顔検出オブジェクト定義

 dbgen_hist
 querygen_hist
% 
% dbgenb
% querygenb

 matching_num = 0;
 
knn_pretreatment

for i = 1:58
    X=Query(:,:,i);
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    flag = knn(Class, X, listing(i).name);

    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);