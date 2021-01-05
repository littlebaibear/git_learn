clear
close all
load positions.mat
img = imread('D:\boli_defect\imgs\use_MVS\12.24\与正常光照对比\条形磁铁+纸板挡光.bmp');
gray_img = rgb2gray(img);
color_list = {'r','g','b','m','c'};
imshow(gray_img),hold on
for i=1:5
%     rectangle('position',positions{i},'curvature',[1,1],'edgecolor','r','facecolor','g'); 
    if i==2
        continue
    end
    rectangle('position',positions{i},'edgecolor',color_list{i}); 
end