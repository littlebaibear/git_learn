% ------------------
%        Matlab�ֶ�����ͼ����ȡ��Ȥ����
% ------------------
clc;
clear;
close all;
% ��һ��ͼƬѡ��Ľ��棬���ص�������Ҫ��ͼƬ���ֺ͵�ַ
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.gif'; '*.png'},'ѡ��ͼƬ');
% û��ͼ��
if filename == 0
    return;
end

origin_img = imread([pathname,filename]);
figure(1);
imshow(origin_img);

% ��ͼ�󣬽������ʮ�ּܣ�����ѡ����Ȥ����
for i=1:5
    h = imrect;
    positions{i} = getPosition(h);% �϶��������Ȥ����pos���ĸ�ֵ����Ȥ�������Ͻǵ��������������ĳ���
%     rois = imcrop(origin_img,positions[i]);
%     figure(2);
%     imshow(roi);
end

% imwrite(roi,'roi.jpg');
