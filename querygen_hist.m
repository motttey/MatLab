
path = '/Users/takamirei/Google ドライブ/情報通信プロジェクト実験B班/dataset/Query/jpeg/';
path_regex = '/Users/takamirei/Google ドライブ/情報通信プロジェクト実験B班/dataset/Query/jpeg/*.jpg';
path_l = '/Users/takamirei/Google ドライブ/情報通信プロジェクト実験B班/dataset/Query/jpeg/*jpg';
path_crop = '/Users/takamirei/Google ドライブ/情報通信プロジェクト実験B班/dataset/Query/crop_hist/';
listing = dir(path_l);
c = 58;
n = 1;

person = 20;


listing = dir(path_regex);

for i = 1:numel(listing)
        str = strcat(path, listing(i).name);
        img = imread(str);
        
        faces = step(detector, img); % 顔検出
        
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
        resize_histeq = histeq(resize);

        filenameonly = strtok(listing(i).name, '.');
        
        filename = strcat(path_crop, filenameonly, 'q_crop.jpg');
        imwrite(resize_histeq, filename);

        Query(:, :, i) = resize_histeq;
        %Query*(:, :, i, j)=img;
end