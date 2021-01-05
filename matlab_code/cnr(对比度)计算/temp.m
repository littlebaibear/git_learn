% ------------------
%        Matlab手动鼠标截图，获取兴趣区域
% ------------------
clc;
clear;
close all;
% 打开一个图片选择的界面，返回的是你需要的图片名字和地址
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif'; '*.png'},'选择图片');
% 没有图像
if filename == 0
    return;
end

origin_img = imread([pathname,filename]);
figure(1);
imshow(origin_img);

% 画图后，将鼠标变成十字架，用来选择兴趣区域
for i=1:5
    h = imrect;
    positions{i} = getPosition(h);% 拖动鼠标获得兴趣区域，pos有四个值，兴趣区域左上角的像素坐标和区域的长宽
%     rois = imcrop(origin_img,positions[i]);
%     figure(2);
%     imshow(roi);
end

% imwrite(roi,'roi.jpg');
