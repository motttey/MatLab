
%  dbgen_hist
%  querygen_hist

pca_test;
DB_MAX = 200;
QUERY_MAX = 58;
Vector_NUM = 3; 
matching_count = 0;

    for j = 1:QUERY_MAX
        Input_Vector = double(Query(:,:,j));
        Input_Vector_Coeff = pca(Input_Vector);
        for i = 1:Vector_NUM
            for k = 1:DB_MAX
                Base_Vector = coeff_list(:,k,i);
                %y = double(DB(:,:,k));
                InputTimesBase1 = transpose(Input_Vector_Coeff(:,i)) * Base_Vector ;
                %InputTimesBase2 = transpose(Base_Vector) * Input_Vector;
                ITB = InputTimesBase1 .* InputTimesBase1;
                Simirarity(k) =+  ITB;
            end
        end
            [maximum, index] = max(Simirarity);
            number = ceil(index/10);

            %result = fprintf('Persion %d \n',number);   
            
            Qname = listing(j).name;
            Qname_token = strtok(Qname, 'q');
            Qname_num = str2num(Qname_token) + 1;
            number=ceil(index/10);

            if (number == Qname_num)
                match_seal = 'Åõ';
                matching_flag = 1;
                matching_count = matching_count + 1;
            else
                match_seal = 'Å~';
                matching_flag = 0;

            end
            result = fprintf('%s is Persion %d %s \n',Qname, number, match_seal);   

    end
    fprintf('matching_num %d \n', matching_count);
