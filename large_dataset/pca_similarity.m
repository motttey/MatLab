init;

%  dbgen_hist
%  querygen_hist

pca_test;
Vector_NUM = 1; 
matching_count = 0;

%Vector_NUM=1のときmatching_count25で最大
for j = 1:QUERY_MAX

    %入力ベクトル: クエリ画像
    %行列→ベクトルに変換するために主成分解析後, i番目の列のみをΣ内で演算
    Input_Vector = double(Query(:,:,j));
    Input_Vector_Coeff = pca(Input_Vector);

    for i = 1:Vector_NUM
        %データベース内の各画像の基底ベクトル
        for k = 1:DB_MAX
            %基底ベクトル: 主成分分析したもの
            Base_Vector = coeff_list(:,k,i);
            %y = double(DB(:,:,k));

            %Σの中の計算
            InputTimesBase1 = transpose(Input_Vector_Coeff(:,i)) * Base_Vector ;
            %InputTimesBase2 = transpose(Base_Vector) * Input_Vector;
            ITB = InputTimesBase1 .* InputTimesBase1;

            %各ベクトルについての演算結果を加算
            Simirarity(k) =+  ITB;
        end
    end
    %最大値を類似度とする
    [maximum, index] = max(Simirarity);
    number = ceil(index/35);

    %result = fprintf('Persion %d \n',number);   

    Qname = listing(j).name;
    Qname_token = strtok(Qname, 'q');
    Qname_num = str2num(Qname_token) + 1;

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
