init;

detector = vision.CascadeObjectDetector();
%true: ƒqƒXƒgƒOƒ‰ƒ€•½’R‰»‚·‚é
%false: •½’R‰»‚µ‚È‚¢
%GUI‚ÅŽg—p‚·‚é true or false
isHist = true;
isGUI = false;
% CreateDataset;

matching_num = 0;

%algorithm 
%use SVM -> svm
%use KNN -> knn
Method = 'knn';

%feature
%use HOG feature -> hog
%use DCT feature -> dct
%use LBP feature -> lbp
feature = 'hog';

% Class = machine_learning_pretreatment(DB, Method, feature);

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
    %flag = matching(DB, X, listing(i).name, 'pca');
       
    %flag = machine_learning(DB, X, listing(i).name, Method, feature, Class);
    
    %perceptron_pretreatment;
    flag = perceptron_predict(net, X, listing(i).name, Method, feature);
    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);
toc;