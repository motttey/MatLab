% for i = 0:19
%     for j = 1:35
%         fprintf('data/train/%d/%03d_crop.png %d\n', i, i*35+j , i);
%     end
% end
for i = 0:19
    if i >12
        n = 4;
    else
        n = 9;
    end
        
        
    for j = 0:n
        fprintf('data/test/%d/%02dq%dq_crop.jpg %d\n', i, i, j, i);
    end
end