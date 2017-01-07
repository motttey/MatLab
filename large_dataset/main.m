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

%use patternnet -> pattern
%use perceptron -> perceptron
network_name = 'pattern';

%feature
%use plane feature -> plane
%use HOG feature -> hog
%use DCT feature -> dct
%use LBP feature -> lbp
neural_feature = 'plane';

net = neural_pretreatment(DB, network_name, neural_feature);

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
       
    %for machine-learning
    %flag = machine_learning(DB, X, listing(i).name, Method, feature, Class);
    
    %for neural networks
    flag = neural_predict(net, X, listing(i).name, network_name, neural_feature);
    
    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);
toc;