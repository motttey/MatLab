function DB = dbgenb(detector)
init;

c = Face_Class_Num;
n = Individual_Face_Num;

Database = zeros(Resize_Width,Resize_Height,DB_MAX);

for i = 1:c
    for j = 1:n
        str = strcat(db_path, num2str(n*(i-1)+j-1, '%03d'), '.jpg');
        if exist(str, 'file') == 2
            img = imread(str);

            % äÁåüèo
            faces = step(detector, img);
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

            filename = strcat(db_path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.jpg');
            imwrite(resize, filename);

            Database(:, :, n*(i-1)+j) = resize;
        else
            fprintf('file "%s" not found\n', str);
        end
    end
end
DB = Database;
end