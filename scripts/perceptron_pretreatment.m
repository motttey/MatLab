 for k = 1:DB_MAX
    quotient = floor((k - 1)/Individual_Face_Num);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(PersonNum,k) = double(1.0);
end
 for j = 1:DB_MAX
    A = DB(:,:,j);
    
      Training(j,:) = extractHOGFeatures(A, 'CellSize', [32 32]);
      %Reshaped_A = reshape(A,1,Resize_Height * Resize_Width);
      %Training(j,:) = double(Reshaped_A);

    %D = (dblX-dblA).^2;    
 end
group_Trans = transpose(Training);
net = perceptron;

net.trainParam.epochs = 5000;
%net.trainParam.goal = 1e-5;
net.trainParam.lr = 0.01;
 %net.trainFcn = 'trainr';
 net.initFcn = 'initlay';                    %ネットワーク初期化関数
 net.adaptFcn = 'adaptwb';
 net.divideFcn = 'dividerand'; %Set the divide function to dividerand (divide training data rndomly).
% 
 net.performFcn = 'crossentropy';
 %
 %net.trainFcn = 'trainlm'; % set training function to trainlm (Levenberg-Marquardt backpropagation) 

net = init(net);
%[x,t] = iris_dataset; %load of the iris data set
net = train(net,group_Trans, group); %training

%view(net);
%訓練後のネットワークの各入力ベクトル(train data)に対する出力を調べる
a = sim(net,group_Trans)         
%損失の計算
% error = [a - group]  
