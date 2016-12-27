function index = pca_similarity(DB, X, Qname)

init;
%  dbgen_hist
%  querygen_hist
pca_test;
Vector_NUM = 1; 
matching_count = 0;

%Vector_NUM=1のときmatching_count25で最大

    %入力ベクトル: クエリ画像
    %行列→ベクトルに変換するために主成分解析後, i番目の列のみをΣ内で演算
    Input_Vector = double(X);
    Input_Vector_Coeff = pca(Input_Vector);

    for i = 1:Vector_NUM
        %データベース内の各画像の基底ベクトル
        for k = 1:DB_MAX
            %基底ベクトル: 主成分分析したもの
            Base_Vector = coeff_list(:,k,i);
            %y = double(DB(:,:,k));

            %Σの中の計算
            length(Base_Vector)
            length(Input_Vector_Coeff(:,i))
            InputTimesBase1 = transpose(Input_Vector_Coeff(:,i)) * Base_Vector ;
            %InputTimesBase2 = transpose(Base_Vector) * Input_Vector;
            ITB = InputTimesBase1 .* InputTimesBase1;

            %各ベクトルについての演算結果を加算
            Simirarity(k) =+  ITB;
        end
    end
    %最大値を類似度とする
    [maximum, index] = max(Simirarity);
    index = ceil(index/Individual_Face_Num);
end