Vector_NUM = 2;
%�e��摜�ɂ��Ď听������
for i = 1:DB_MAX
    y = double(DB(:,:,i));
    [COEFF,SCORE,LATENT] = pca(y);
    %���Vector_NUM�̍s��𒊏o
    for j = 1:Vector_NUM
        coeffs = COEFF(:,j);
        coeff_list(:,i,j) = coeffs;
    end
end


% �P��摜�ɑ΂���pca�v�Z
% k = [1 2; 4 5; 7 8];
% 
% A = imread('img1.png');
% X = double(A);
% �听��, �听���X�R�A, �听�����U
% [COEFF,SCORE,LATENT] = pca(X);
% 
% coeff = pca(X);