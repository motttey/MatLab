function [Query, listing] = querygen_hist(detector)
init;

c = QUERY_MAX;
n = 1;

person = Face_Class_Num;
listing = dir(query_path_regex);

Query_List = zeros(Resize_Width, Resize_Height, QUERY_MAX);


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

        fmax = 255;
        fmin = 0;

        resize = imresize(crop, [Resize_Width Resize_Width]);
        resize_med = medfilt2(resize);

        resize2 = imcrop(resize,[7 7 50 50]);
        resize_histeq = medfilt2(histeq(resize_med));

        filenameonly = strtok(listing(i).name, '.');

        filename = strcat(query_path_crop, filenameonly, 'q_crop.png');
        imwrite(resize_med, filename);
        Query_List(:, :, i) = resize_histeq;
    else
        fprintf('file "%s" not found\n', str);
    end
end
Query = Query_List;
end