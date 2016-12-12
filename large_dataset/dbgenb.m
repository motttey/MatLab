c = 20;
n = 10;

path = '/path/to/dataset/DB/jpeg/';
path_crop = '/path/to/dataset/Query/crop_hist/';

for i = 1:c
    for j = 1:n
        str = strcat(path, num2str(n*(i-1)+j-1, '%03d'), '.jpg');
        img = imread(str);
        
        faces = step(detector, img); % äÁåüèo
        
        if isempty(faces)
            crop = imcrop(img);
            close;
        elseif numel(faces)~=4
            [M, N] = max(faces);
            faces = faces(N(3), :);
            crop = imcrop(img, faces);
        else
            crop = imcrop(img, faces);
        end
        
        resize = imresize(crop, [150 150]);
        
        filename = strcat(path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.jpg');
        imwrite(resize, filename);

        DB(:, :, n*(i-1)+j) = resize;
        %DB(:, :, i, j)=img;
    end
end