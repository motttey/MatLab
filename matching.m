function matching_flag = matching(DB, X, Qname)
    
    %Ratio num/55
    dblX = double(X);
    
    
    
    
    %ZNCC 34 
    %ZNCC hist 31
%      for i = 1:200
%          
%          A = DB(:,:,i);
%          dblA = double(A);   
%          
%          for j = 1:150
%              for k = 1:150
%                 APower2(j,k) = dblA(j,k).^2;
%                 XPower2(j,k) = dblX(j,k).^2;
%                 AtimesX(j,k) = dblA(j,k)*dblX(j,k);
%              end
%          end
%          APower2Sum = sum(sum(APower2));
%          XPower2Sum = sum(sum(XPower2));
%          AtimesX2Sum = sum(sum(AtimesX));
%          ASum = sum(sum(dblA));
%          XSum = sum(sum(dblX));
%          
%          ZNCC = (150.^2 * AtimesX2Sum - ASum*XSum) / sqrt( (150.^2*APower2Sum - ASum.^2)*(150.^2*XPower2Sum - XSum.^2) );
%          distance(i) = abs(1-ZNCC);
%      end
%   [minimum, index] = min(distance);
     
    %NCC 33
    %NCC 32 +histeq
%      dblX = double(X);
%      for i = 1:200
%          
%          A = DB(:,:,i);
%          dblA = double(A);   
%          
%          for j = 1:150
%              for k = 1:150
%                 APower2(j,k) = dblA(j,k).^2;
%                 XPower2(j,k) = dblX(j,k).^2;
%                 AtimesX(j,k) = dblA(j,k)*dblX(j,k);
%              end
%          end
%          APower2Sum = sum(sum(APower2));
%          XPower2Sum = sum(sum(XPower2));
%          AtimesX2Sum = sum(sum(AtimesX));
%          
%          distance(i) = abs( 1 - (AtimesX2Sum / sqrt(APower2Sum*XPower2Sum)));
%      end
%   [minimum, index] = min(distance);
     
%plane: Score 29
%plane + histeq 33
%      dblX = double(X);
%      for i = 1:200
%         A = DB(:,:,i);
%          dblA = double(A);
%          D = (dblX-dblA).^2;
%          distance(i) = sum(sum(D));
%      end
%   [minimum, index] = min(distance);


 %edge + histeq 17
 %edge: 15
 
%      edgeX = edge(X, 'sobel');
%      edgeXdbl = double(edgeX);
%      for i = 1:200
%          A = DB(:,:,i);
%          edgeA = edge(A, 'sobel');
%          edgeAdbl = double(edgeA);
%          D = (edgeXdbl-edgeAdbl).^2;
%          distance(i) = sum(sum(D));
%      end
%      [minimum, index] = min(distance);

    %DCT + histeq 32
    %DCT: Score 30

%     dblX = double(X);
%     dctX = dct2(dblX); %2次元DCT
%     dctXlow = dctX(1:10, 1:10); %DCT低域成分の取り出し
%     for i = 1:200
%         A = DB(:,:,i);
%         dblA = double(A);
%         dctA = dct2(dblA); %2次元DCT
%         dctAlow = dctA(1:10, 1:10); %DCT低域成分の取り出し
%         %D = (dblX-dblA).^2;
%         D = (dctXlow-dctAlow).^2;
%         distance(i) = sum(sum(D));
%     end
%     [minimum, index] = min(distance);

    %Histgram Intersection 22
    %Histgram Intersection + histeq 12
    %hist: Score 1
    %hist + histeq 7
%     Histgram_Length = 256;
%     X1 = X(:);
%     dblX = double(X1);
%     histX = hist(dblX, 256); %ヒストグラム
%    
%     
%     for i = 1:200
%             A = DB(:,:,i);
%             A1 = A(:);
%             %1次元化
%             dblA = double(A1);
%             histA = hist(dblA, 256);%ヒストグラム
%             histsum = 0;
%             histAsum = 0;
%         for j = 1:Histgram_Length
%             histsum = histsum + max(histA(j),histX(j));
%             histAsum = histAsum + histA(j);
%             %D = (histX-histA).^2;
%         end
%             Similar_degrees = histsum/ histAsum;
%             distance(i) = abs(1 - Similar_degrees) ;    
%     end
%     %[minimum, index] = min(distance);
    %distance
    %

    %figure
    %A=DB
    %imshow(A)
    
    %POC 20
    %POC +histeq 26
%     dblX = double(X);
%     for i=1:200;
%             A = DB(:,:,i);
%             dblA = double(A);
%             P = poc(dblA,dblX);
%             distance(i) = max(max(P));        
%     end
    
    %POC + edge(sobel) 32
    %POC + edge(sobel) + histeq 33
    %POC + edge(Canny) 31
    %POC + edge(Canny) + histeq 29
    edgeX = edge(X, 'Canny');
    edgeXdbl = double(edgeX);

    for i=1:200;
            A = DB(:,:,i);
            edgeA = edge(A, 'Canny');
            edgeAdbl = double(edgeA);
            P = poc(edgeAdbl, edgeXdbl);
            distance(i) = max(max(P));        
    end

    
    [maximum, index] = max(distance);
    
    number = ceil(index/10);
    %fprintf(' is Person %d.\n', number)
    
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    number=ceil(index/10);
    
    if (number == Qname_num)
        match_seal = '○';
        matching_flag = 1;

    else
        match_seal = '×';
        matching_flag = 0;

    end
          
    result = fprintf('%s is Persion %d %s \n',Qname, number, match_seal);   
end

