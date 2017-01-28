function [Query, listing] = querygenb(detector)

init;
c = QUERY_MAX;
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

        resize = imresize(crop, [Resize_Width Resize_Width]);
        resize_med = medfilt2(resize);

        filenameonly = strtok(listing(i).name, '.');

        filename = strcat(query_path_crop, filenameonly, 'q_crop.png');
        imwrite(resize_med, filename);

        Query_List(:, :, i) = resize;
    else
        fprintf('file "%s" not found\n', str);
    end
end
Query = Query_List;
end