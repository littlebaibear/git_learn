clc
clear
close all;
% I1 = imread('C:\Users\ztx\Desktop\全反射玻璃图片\IMG_20201207_171251.jpg');
% I2 = imread('C:\Users\ztx\Desktop\全反射玻璃图片\IMG_20201207_171336.jpg');
I1 = imread('C:\Users\ztx\Desktop\白光线光源全反射成像12.6\20.6.jpg');
I2 = imread('C:\Users\ztx\Desktop\白光线光源全反射成像12.6\21.7.jpg');
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

figure,
imshow(I1)
% impixelinfo;
figure,
imshow(I2)

% positions = generate_roi(I1);

for i =1:5
    h = imrect;
    positions = round(getPosition(h));
    rois_1{i} = I1(positions(2):positions(2)+positions(4),positions(1):positions(1)+positions(3));
    rois_2{i} = I2(positions(2):positions(2)+positions(4),positions(1):positions(1)+positions(3));
end

figure
result1 = abs(cnr(rois_1{1},rois_1{2},rois_1{3},rois_1{4},rois_1{5}));
subplot(251),imshow(rois_1{1})
subplot(252),imshow(rois_1{2})
subplot(253),imshow(rois_1{3})
subplot(254),imshow(rois_1{4})
subplot(255),imshow(rois_1{5})
suptitle('pic1')
result2 = abs(cnr(rois_2{1},rois_2{2},rois_2{3},rois_2{4},rois_2{5}));
subplot(256),imshow(rois_2{1})
subplot(257),imshow(rois_2{2})
subplot(258),imshow(rois_2{3})
subplot(259),imshow(rois_2{4})
subplot(2,5,10),imshow(rois_2{5})
suptitle('pic2')


% a = std2(I1);
% b = std2(I2);
% figure
% plot(size(a),a,'ro')
% hold on
% plot(size(b),b,'bo')