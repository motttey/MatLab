init;

%true: ヒストグラム平坦化する
%false: 平坦化しない
%GUIで使用する true or false
isHist = true;
isGUI = false;
%データセット変えた場合には作り直す必要があるのでtrue
isReadImage = true;
if isReadImage
    [DB, Query, listing] = CreateDataset(isHist, isGUI, isReadImage);
end
%matching-method
%1:matching, 2:machine_lerning, 3: neural
matching_method = 3;

%マッチした数
matching_num = 0;

switch(matching_method)
    case {1,'plene'}
    case {2,'machine'}
        %algorithm 
        %use SVM -> svm
        %use KNN -> knn
        Method = 'svm';

        %feature
        %use HOG feature -> hog
        %use DCT feature -> dct
        %use LBP feature -> lbp
        feature = 'hog';

        Class = machine_learning_pretreatment(DB, Method, feature);
    case {3,'neural'}
        %use patternnet -> pattern
        %use perceptron -> perceptron
        network_name = 'pattern';

        %neural_feature
        %use plene feature -> plene
        %use HOG feature -> hog
        %use DCT feature -> dct
        %use LBP feature -> lbp
        neural_feature = 'lbp';
        isReject = false;
        
        net = neural_pretreatment(DB, network_name, neural_feature);
        %view(net);
     case {4,'tree'}
        %use normal classification tree -> normal
        %use random forest -> bagger
        tree_name = 'normal';

        %neural_feature
        %use plene feature -> plene
        %use HOG feature -> hog
        %use DCT feature -> dct
        %use LBP feature -> lbp
        tree_feature = 'lbp';

        tree = tree_pretreatment(DB, tree_name, tree_feature);
    otherwise
end

tic;
for i = 1:QUERY_MAX
    X=Query(:,:,i);
    switch(matching_method)
        case {1,'plene'}
            %plene ->plene
            %use NCC for Degree of similarity -> ncc
            %use ZNCC for Degree of similarity -> zncc
            %use strong point -> strong_point
            %use poc -> poc
            %use pca(clafic) -> pca
            %use edge for feature -> edge
            %use histgram for feature -> hist
            %use DCT for feature ->dct
            flag = matching(DB, X, listing(i).name, 'dct');
        case {2,'machine'} 
            %for machine-learning
            flag = machine_learning(DB, X, listing(i).name, Method, feature, Class);
        case {3,'neural'} 
            %for neural networks
            flag = neural_predict(net, X, listing(i).name, network_name, neural_feature, isReject);
        case {4,'tree'} 
            %for classification tree
            flag = tree_predict(tree, X, listing(i).name, tree_name, tree_feature);
        otherwise
            flag = matching(DB, X, listing(i).name, 'plene');            
    end       
    
    if flag == 1
        matching_num = matching_num + 1;
    end
end
fprintf('matching_num %d \n', matching_num);
toc;