function [DB, Query, listing] = CreateDataset(isHist, isGUI, isReadImage)
    init;
    detector = vision.CascadeObjectDetector();
    
    switch(isHist)
        case true
            DB = dbgen_hist(detector);
            if isGUI == false 
                [Query, listing] = querygen_hist(detector);
            end
        case false
            DB = dbgenb(detector);
            if isGUI == false 
                [Query, listing] = querygenb(detector);
            end
        otherwise
            fprintf('isHist is not set');
    end

end