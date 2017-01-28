SumOfFace = zeros(Resize_Width, Resize_Height);
%ŠeŠç‰æ‘œ‚É‚Â‚¢‚Äå¬•ª•ªÍ
for i = 1:DB_MAX
    y = double(DB(:,:,i));
    SumOfFace = SumOfFace + y;
end

MeanOfFace = int8(SumOfFace / DB_MAX);
h = fspecial('gaussian', 15, 6);
 
image_g = imfilter(MeanOfFace, h, 'replicate');
%imshow(image_g);
