%init;

%true: �q�X�g�O�������R������
%false: ���R�����Ȃ�
CreateDataset(true);

matching_num = 0;
 
%knn_pretreatment
tic;
for i = 1:QUERY_MAX
    X=Query(:,:,i);
    %fprintf('%d', i)
    %flag = matching(DB, X, listing(i).name);
    
    %
    knn_hog_pretreatment;
    flag = knn_hog(Class, X, listing(i).name);

    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);
toc;