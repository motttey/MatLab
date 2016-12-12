function [Y] = modified_abs(X)
    [m,n] = size(X);
    Y = abs(X);
    for i=1:m
        for j=1:n
            if Y(i,j) == 0.0
                Y(i,j) = 1.0;
            end
        end
    end
end

            