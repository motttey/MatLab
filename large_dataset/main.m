init;

%true: ƒqƒXƒgƒOƒ‰ƒ€•½’R‰»‚·‚é
%false: •½’R‰»‚µ‚È‚¢
CreateDataset(true);

matching_num = 0;
 
%knn_pretreatment
tic;
for i = 1:QUERY_MAX
    X=Query(:,:,i);
    
    %use NCC for Degree of similarity -> ncc
    %use ZNCC for Degree of similarity -> zncc
    %use strong point -> strong point
    %use poc -> poc
    %use edge for feature -> edge
    %use histgram for feature -> hist
    %use DCT for feature ->dct
    flag = matching(DB, X, listing(i).name, 'dct');
       
%     knn_hog_pretreatment;
%     flag = knn_hog(Class, X, listing(i).name);

    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);
toc;