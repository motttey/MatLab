Vector_NUM = 2;
%各顔画像について主成分分析
for i = 1:DB_MAX
    y = double(DB(:,:,i));
    [COEFF,SCORE,LATENT] = pca(y);
    %上位Vector_NUM個の行列を抽出
    for j = 1:Vector_NUM
        coeffs = COEFF(:,j);
        coeff_list(:,i,j) = coeffs;
    end
end


% 単一画像に対するpca計算
% k = [1 2; 4 5; 7 8];
% 
% A = imread('img1.png');
% X = double(A);
% 主成分, 主成分スコア, 主成分分散
% [COEFF,SCORE,LATENT] = pca(X);
% 
% coeff = pca(X);