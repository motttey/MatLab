init;
switch(isHist)
    case true
        dbgen_hist;
        querygen_hist;
    case false
        dbgenb;
        querygenb;
    otherwise 
        fprintf('isHist is not set');
end
