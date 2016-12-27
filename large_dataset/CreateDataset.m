init;
switch(isHist)
    case true
        dbgen_hist;
        if isGUI == false 
            querygen_hist;
        end
    case false
        dbgenb;
        if isGUI == false 
            querygenb;
        end
        otherwise
        fprintf('isHist is not set');
end
