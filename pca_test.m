% DB_MAX = 200;
% coeffs.size = 200;
% 
% for i = 1:DB_MAX
%     y = double(DB(:,:,i));
%     coeff = pca(y);
%     coeffs(i) = coeff;
% end
% 

%�P��摜�ɑ΂���pca�v�Z
k = [1 2; 4 5; 7 8];

A = imread('img1.png');
X = double(A);
%�听��, �听���X�R�A, �听�����U
[COEFF,SCORE,LATENT] = pca(X);

%coeff = pca(X);