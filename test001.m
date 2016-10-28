I = imread('M:\MATLAB\DB\jpeg\192.jpg'); % 画像の読込み
detector = vision.CascadeObjectDetector(); % 顔検出オブジェクト定義
faces = step(detector, I) % 顔検出
I2 = insertObjectAnnotation(I, 'rectangle', faces, 'Face'); %枠描画
figure; imshow(I2); % 表示
numel(faces)
x = imcrop(I, faces);
y = imresize(x, [150 150]);

imshow(y)