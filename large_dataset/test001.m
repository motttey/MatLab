I = imread('M:\MATLAB\DB\jpeg\192.jpg'); % �摜�̓Ǎ���
detector = vision.CascadeObjectDetector(); % �猟�o�I�u�W�F�N�g��`
faces = step(detector, I) % �猟�o
I2 = insertObjectAnnotation(I, 'rectangle', faces, 'Face'); %�g�`��
figure; imshow(I2); % �\��
numel(faces)
x = imcrop(I, faces);
y = imresize(x, [150 150]);

imshow(y)