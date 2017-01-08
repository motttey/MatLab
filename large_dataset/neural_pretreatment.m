function net = neural_pretreatment(DB, network_name, neural_feature)
    init;
    for k = 1:DB_MAX
        quotient = floor((k - 1)/Individual_Face_Num);
        PersonNum = quotient + 1;
        str = strcat('Person: ', PersonNum);
        group(PersonNum,k) = double(1.0);
    end
     for j = 1:DB_MAX
        A = DB(:,:,j);
        switch neural_feature
            case {'plene'}
                Reshaped_A = reshape(A,1,Resize_Height * Resize_Width);
                Training(j,:) = double(Reshaped_A);
            case {'hog', 'HOG'}
                Training(j,:) = extractHOGFeatures(A, 'CellSize', [HOG_Cell_Size HOG_Cell_Size]);
            case {'LBP', 'lbp'}
                Training(j,:) = extractLBPFeatures(A, 'Upright', false);
            case {'DCT', 'dct'}
                dblA = double(A);
                dctA = dct2(dblA); %2����DCT
                dctAlow = dctA(1:6, 1:6); %DCT��搬���̎��o��
                Training(j,:) = reshape(dctAlow,1,36);
            otherwise     
                Reshaped_A = reshape(A,1,Resize_Height * Resize_Width);
                Training(j,:) = double(Reshaped_A);
        end
        %D = (dblX-dblA).^2;    
     end
    group_Trans = transpose(Training);
    net = perceptron;

    switch network_name
        case 'pattern'
            net = patternnet(50);
            net.trainParam.max_fail = 5;
            net.trainParam.epochs = 5000;
            net.trainParam.lr = 0.01;

            net.initFcn = 'initlay';                    %�l�b�g���[�N�������֐�
            net.adaptFcn = 'adaptwb';
            net.divideFcn = 'dividerand'; 
            %Set the divide function to dividerand (divide training data rndomly).
            net.performFcn = 'crossentropy';
        case 'perceptron'
            net = perceptron;
            net.trainParam.epochs = 5000;
            %net.trainParam.goal = 1e-5;
            net.trainParam.lr = 0.01;
            %net.trainFcn = 'trainr';
            net.initFcn = 'initlay';                    %�l�b�g���[�N�������֐�
            net.adaptFcn = 'adaptwb';
            net.divideFcn = 'dividerand'; 
            %Set the divide function to dividerand (divide training data rndomly).
            net.performFcn = 'mse';
    end
    
     %
     %net.trainFcn = 'trainlm'; % set training function to trainlm (Levenberg-Marquardt backpropagation) 

    net = init(net);
    %[x,t] = iris_dataset; %load of the iris data set
    net = train(net,group_Trans, group); %training

    %view(net);
    %�P����̃l�b�g���[�N�̊e���̓x�N�g��(train data)�ɑ΂���o�͂𒲂ׂ�
    a = sim(net,group_Trans)         
    %�����̌v�Z
    % error = [a - group]  

end