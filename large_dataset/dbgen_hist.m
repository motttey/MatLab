c = 21;
n = 35;

path = '/path/to/face_class/DB/';
path_crop = '/path/to/face_class/DB/crop_hist/';

for i = 1:c
    if i == 21
        n = 29;
    end
    for j = 1:n
        str = strcat(path, num2str(n*(i-1)+j, '%03d'), '.png');
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
        
        resize = imresize(crop, [36 36]);
        resize_histeq = histeq(resize);
        
        filename = strcat(path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.png');
        imwrite(resize_histeq, filename);

        DB(:, :, n*(i-1)+j) = resize_histeq;
        %DB(:, :, i, j)=img;
    end
end