function index = zncc(DB, X, Qname)

%Ratio num/55
    dblX = double(X);
%  
%     ZNCC 34 
%     ZNCC hist 31
     for i = 1:DB_MAX
         
         A = DB(:,:,i);
         dblA = double(A);   
         
         for j = 1:Resize_Width
             for k = 1:Resize_Height
                APower2(j,k) = dblA(j,k).^2;
                XPower2(j,k) = dblX(j,k).^2;
                AtimesX(j,k) = dblA(j,k)*dblX(j,k);
             end
         end
         APower2Sum = sum(sum(APower2));
         XPower2Sum = sum(sum(XPower2));
         AtimesX2Sum = sum(sum(AtimesX));
         ASum = sum(sum(dblA));
         XSum = sum(sum(dblX));
         
         ZNCC = (150.^2 * AtimesX2Sum - ASum*XSum) / sqrt( (150.^2*APower2Sum - ASum.^2)*(150.^2*XPower2Sum - XSum.^2) );
         distance(i) = abs(1-ZNCC);
     end
  [minimum, index] = min(distance);
end