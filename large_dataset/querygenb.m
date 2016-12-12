

path = '/path/to/dataset/Query/jpeg/';
path_regex = '/path/to/dataset/Query/jpeg/*.jpg';
path_l = '/path/to/dataset/Query/jpeg/*jpg';
path_crop = '/path/to/dataset/Query/crop_hist/';
listing = dir(path_l);
c = 58;
n = 1;

person = 20;


listing = dir(path_regex);

for i = 1:numel(listing)
        str = strcat(path, listing(i).name);
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
        
        filenameonly = strtok(listing(i).name, '.');
        
        filename = strcat(path_crop, filenameonly, 'q_crop.jpg');
        imwrite(resize, filename);

        Query(:, :, i) = resize;
        %Query*(:, :, i, j)=img;
end