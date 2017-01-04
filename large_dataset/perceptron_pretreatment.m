 for k = 1:DB_MAX
    quotient = floor((k - 1)/Individual_Face_Num);
    PersonNum = quotient + 1;
    str = strcat('Person: ', PersonNum);
    group(PersonNum,k) = 1;
end
 for j = 1:DB_MAX
    A = DB(:,:,j);
    
            Training(j,:) = extractHOGFeatures(A, 'CellSize', [2 2]);
    
    %D = (dblX-dblA).^2;    
 end
group_Trans = transpose(Training);
net = perceptron;
net.trainParam.epochs = 5000;

%net.adaptFcn = 'adaptwb';
%net.divideFcn = 'dividerand'; %Set the divide function to dividerand (divide training data randomly).

net.performFcn = 'mse';
 
%net.trainFcn = 'trainlm'; % set training function to trainlm (Levenberg-Marquardt backpropagation) 
% 
% net.plotFcns = {'plotperform', 'plottrainstate', 'ploterrhist', 'plotconfusion', 'plotroc'};
% 
% %set Layer1
% net.layers{1}.name = 'Layer 1';
% net.layers{1}.dimensions = 20;
% net.layers{1}.initFcn = 'initnw';
% net.layers{1}.transferFcn = 'tansig';

net = train(net,group_Trans, group); %training

%y = net(x); %prediction

view(net);
%view(net);
a = sim(net,group_Trans)              %訓練後のネットワークの各入力ベクトルに対する出力を調べる
% error = [a - group]  
