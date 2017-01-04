listing = dir(query_path_l);
c = QUERY_MAX;

person = Face_Class_Num;

listing = dir(query_path_regex);

for i = 1:numel(listing)
    str = strcat(query_path, listing(i).name);
    if exist(str, 'file') == 2
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
        
        resize = imresize(crop, [Resize_Width Resize_Width]);
        resize_histeq = medfilt2(histeq(resize));
        
        filenameonly = strtok(listing(i).name, '.');
        
        filename = strcat(query_path_crop, filenameonly, 'q_crop.png');
        imwrite(resize, filename);

        Query(:, :, i) = resize;
        %Query*(:, :, i, j)=img;
    else
        fprintf('file "%s" not found\n', str);
    end
end