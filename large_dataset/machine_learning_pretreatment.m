function Class = machine_learning_pretreatment(DB, Method, feature)
    init;
    switch Method
        case {'KNN','knn'}
            Class = knn_pretreatment(DB, feature);
        case {'SVM','svm'}
            Class = svm_pretreatment(DB, feature);
    end

end