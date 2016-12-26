function CreateDataset(isHist)
    init;
    switch(isHist)
        case true
            dbgenb;
            querygenb;
        case false
            dbgen_hist;
            querygen_hist;
        otherwise 
            fprintf('isHist is not set');
    end
end