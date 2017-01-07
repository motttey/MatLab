c = Face_Class_Num;
n = Individual_Face_Num;

for i = 1:c

    for j = 1:n
        str = strcat(db_path, num2str(n*(i-1)+j, '%03d'), '.png');
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
            resize_med = medfilt2(resize);
            resize2 = imcrop(resize,[7 7 50 50]);
            resize_histeq = medfilt2(histeq(resize_med));

            filename = strcat(db_path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.png');
            imwrite(resize_histeq, filename);

            DB(:, :, n*(i-1)+j) = resize_histeq;
            %DB(:, :, i, j)=img;
        else
            fprintf('file "%s" not found\n', str);
        end
    end
end