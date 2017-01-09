function DB = dbgen_hist(detector)

init;
c = Face_Class_Num;
n = Individual_Face_Num;

Database = zeros(Resize_Width,Resize_Height,DB_MAX);

for i = 1:c
    for j = 1:n
        str = strcat(db_path, num2str(n*(i-1)+j-1, '%03d'), '.jpg');
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

            fmax = 255;
            fmin = 0;

            resize = imresize(crop, [Resize_Width Resize_Width]);
            resize_med = medfilt2(resize);
            Q3 = (fmax-fmin)/ (2^7 -1);
            s3 = round(double(resize)/Q3);
            fq3 = uint8(s3*Q3);
            resize2 = imcrop(resize,[7 7 50 50]);
            resize_histeq = medfilt2(histeq(fq3));

            filename = strcat(db_path_crop, num2str(n*(i-1)+j-1, '%03d'), '_crop.png');
            imwrite(resize_histeq, filename);
            Database(:, :, n*(i-1)+j) = resize_histeq;
        else
            fprintf('file "%s" not found\n', str);

        end
    end
end
DB = Database;
end