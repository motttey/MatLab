function index = pca_similarity(DB, X, Qname)

init;
%  dbgen_hist
%  querygen_hist
pca_test;
Vector_NUM = 1; 
matching_count = 0;

%Vector_NUM=1�̂Ƃ�matching_count25�ōő�

    %���̓x�N�g��: �N�G���摜
    %�s�񁨃x�N�g���ɕϊ����邽�߂Ɏ听����͌�, i�Ԗڂ̗�݂̂������ŉ��Z
    Input_Vector = double(X);
    Input_Vector_Coeff = pca(Input_Vector);

    for i = 1:Vector_NUM
        %�f�[�^�x�[�X���̊e�摜�̊��x�N�g��
        for k = 1:DB_MAX
            %���x�N�g��: �听�����͂�������
            Base_Vector = coeff_list(:,k,i);
            %y = double(DB(:,:,k));

            %���̒��̌v�Z
            length(Base_Vector)
            length(Input_Vector_Coeff(:,i))
            InputTimesBase1 = transpose(Input_Vector_Coeff(:,i)) * Base_Vector ;
            %InputTimesBase2 = transpose(Base_Vector) * Input_Vector;
            ITB = InputTimesBase1 .* InputTimesBase1;

            %�e�x�N�g���ɂ��Ẳ��Z���ʂ����Z
            Simirarity(k) =+  ITB;
        end
    end
    %�ő�l��ގ��x�Ƃ���
    [maximum, index] = max(Simirarity);
    index = ceil(index/Individual_Face_Num);
end