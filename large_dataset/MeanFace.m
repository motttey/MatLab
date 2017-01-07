%ŠeŠç‰æ‘œ‚É‚Â‚¢‚Äå¬•ª•ªÍ
init;
ysum = zeros(Resize_Width,Resize_Height);
Vector_NUM = 1; 
FACE_MAX = Face_Class_Num;
matching_count = 0;
Base_Vector = zeros(Resize_Width, 1);
i = 0;
k = 1;

for i = 1:DB_MAX
    y = double(DB(:,:,i));
    ysum = ysum + y;
    if rem(i,Individual_Face_Num) == 0 || i == DB_MAX
        y_mean = (ysum / Individual_Face_Num);
        index = ceil(i/Individual_Face_Num);
        Mean_face(:,:,k) = uint8(y_mean);
        ysum = zeros(Resize_Width,Resize_Height);
        k = k + 1;
    end
end