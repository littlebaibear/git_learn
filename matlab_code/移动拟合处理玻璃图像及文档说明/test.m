close all;
I1 = imread('C:\Users\ztx\Desktop\È«·´Éä²£Á§Í¼Æ¬\IMG_20201207_171251.jpg');
I2 = imread('C:\Users\ztx\Desktop\È«·´Éä²£Á§Í¼Æ¬\IMG_20201207_171336.jpg');
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

figure
imshow(I1)
% impixelinfo;

hold on
imshow(I2)
figure
rois_1 = generate_roi(I1)
% roi1 = I1(2615:2659,911:941);
% roi2 = I1(1770:1800,1288:1325);
% roi3 = I1(923:989,783:851);
% roi4 = I1(720:770,1840:1900);
% roi5 = I1(1770:1800,1288:1325);
subplot(151),imshow(rois_1{1})
subplot(152),imshow(rois_1{2})
subplot(153),imshow(rois_1{3})
subplot(154),imshow(rois_1{4})
subplot(155),imshow(rois_1{5})
result1 = abs(cnr(rois_1{1},rois_1{2},rois_1{3},rois_1{4},rois_1{5}));


% a = std2(I1);
% b = std2(I2);
% figure
% plot(size(a),a,'ro')
% hold on
% plot(size(b),b,'bo')