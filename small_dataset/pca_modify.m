detector = vision.CascadeObjectDetector(); % 顔検出オブジェクト定義
 
% dbgen_hist
 %querygen_hist
tic;
%各顔画像について主成分分析

face_mean;
ysum = zeros(32,32);
Vector_NUM = 1; 
DB_MAX = 200;
QUERY_MAX = 58;
FACE_MAX = 20;
matching_count = 0;
Base_Vector = zeros(32, 1);
i = 0;
k = 0;

for i = 1:DB_MAX
    y = double(DB(:,:,i));
    ysum = ysum + y;
    if rem(i,10) == 0
        y_mean = (ysum / 10) - double(MeanOfFace);
        %ysum
        imshow(uint8(y_mean));
        index = ceil(i/10);
        %fprintf('index%d\n', index);
        sigma = cov(ysum);
        [vec val] = eigs(sigma);
        %[sortMat val_sort] = sort(val, 'descend');
        %[B, IX] = sort(sortMat(1,:), 'descend');
            %[r c] = find(val == min(val(:)));


        %上位Vector_NUM個の行列を抽出
        for j = 1:Vector_NUM
            w = transpose(vec(:,j));
            coeff_list(:,index,j) = w;
        end
        ysum = zeros(32,32);
    end
end
%Vector_NUM=1のときmatching_count25で最大
for j = 1:QUERY_MAX

    %入力ベクトル: クエリ画像
    %行列→ベクトルに変換するために主成分解析後, i番目の列のみをΣ内で演算
    Input_Vector = double(Query(:,:,j));
    %Input_Vector_Coeff = pca(Input_Vector);
    sigmaQ = cov(Input_Vector);
    [vecQ valQ] = eigs(sigmaQ);


        %データベース内の各画像の基底ベクトル
        %Base_Vector = zeros(150, 1);
        for k = 1:FACE_MAX
                
                %Σの中の計算
                for i = 1:Vector_NUM
                    wQ = transpose(vecQ(:,i));
                    Base_Vector =  coeff_list(:,k,i) ;
                    InputTimesBase1 = dot(Base_Vector, wQ) ;
                    ITB =+  transpose(InputTimesBase1) * InputTimesBase1;
                end
            %基底ベクトル: 主成分分析したもの
            %Base_Vector =  coeff_list(:,k) ;
            %y = double(DB(:,:,k));

            %Σの中の計算

            %各ベクトルについての演算結果を加算
            Simirarity(k) =  ITB;
        end
    %最大値を類似度とする
    [maximum, index] = max(Simirarity);
    %number = ceil(index/10);
    number = index;
    

    %result = fprintf('Persion %d \n',number);   

    Qname = listing(j).name;
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;
    %number=ceil(index/10);

    if (number == Qname_num)
        match_seal = '○';
        matching_flag = 1;
        matching_count = matching_count + 1;
    else
        match_seal = '×';
        matching_flag = 0;

    end
    result = fprintf('%s is Persion %d %s \n',Qname, number, match_seal);   

end
fprintf('matching_num %d \n', matching_count);
toc;