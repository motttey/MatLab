
path = '/path/to/face_class/Query/';
path_regex = '/path/to/face_class/Query/*.png';
path_l = '/path/to/face_class/Query/*png';
path_crop = '/path/to/face_class/Query/crop_hist/';
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
        
        resize = imresize(crop, [36 36]);
        resize_histeq = histeq(resize);

        filenameonly = strtok(listing(i).name, '.');
        
        filename = strcat(path_crop, filenameonly, 'q_crop.jpg');
        imwrite(resize_histeq, filename);

        Query(:, :, i) = resize_histeq;
        %Query*(:, :, i, j)=img;
end