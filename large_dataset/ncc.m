function index = ncc(DB, X, Qname)

    dblX = double(X);
   
    %NCC 33
    %NCC 32 +histeq
     dblX = double(X);
     for i = 1:200
         
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
         
         distance(i) = abs( 1 - (AtimesX2Sum / sqrt(APower2Sum*XPower2Sum)));
     end
  [minimum, index] = min(distance);
end