clear
close all
path = 'D:\boli_defect\imgs\use_MVS\12.28\0002\hd_10w_0.bmp';
I=imread(path);
% 'D:\boli_defect\imgs\use_MVS\12.22\底部垫片反射缺陷折射光.bmp'

bg = imread('D:\boli_defect\imgs\use_MVS\12.28\无玻璃.bmp');
I =  I-bg;


% impixelinfo
I1=rgb2gray(I);
% 滤波
% I1 = medfilt2(I1);
%% 局部自适应阈值分割
se = strel('disk',15);
background = imopen(I1,se);
I2 = I1-background;

bw0 = imbinarize(I2,adaptthresh(I2,'NeighborhoodSize',15));
figure,imshow(bw0)

%% 图像tophat处理后+大津法全局阈值分割
disp('顶帽操作去除背景,再做分割:');
% 开运算会删除无法完全包含结构元素的小对象
tic
se = strel('disk',15);
background = imopen(I1,se);
I2 = I1-background;
bw = imbinarize(I2);
toc

figure
subplot(221),imshow(background),title('开运算')
subplot(222),imshow(I2),title('顶帽')

% close_img = imclose(I1,se);
% % close_img = imerode(I1,se);
% I3 = close_img-I1;
% subplot(223),imshow(close_img),title('闭运算')
% subplot(224),imshow(I3),title('底帽')

figure
subplot(221),imshow(I1),title('原图')
subplot(222),imshow(I2),title('顶帽')


bw2 = imbinarize(I2,'adaptive');

% bw2 = bwareaopen(bw2,50);
% bw = bwareaopen(bw,50);
subplot(223),imshow(bw),title('顶帽大津二值化')
subplot(224),imshow(bw2),title('顶帽自适应二值化')

%% 原图-局部异界自适应阈值,得到背景均匀的图像,进而使用大津法全局阈值分割
close all
% se = strel('disk',35);
% % figure,imshowpair(I2,histeq(I2),imtophat(histeq(I2),se),'montage')
% figure
% % montage({I2,histeq(I2),imtophat(histeq(I2),se),histeq(I2)-imtophat(histeq(I2),se)})
% montage({I1,histeq(I1),imtophat(histeq(I1),se),I1-imtophat(histeq(I1),se)})
% figure
% montage({I2,imadjust(I2),imtophat(imadjust(I2),se),imadjust(I2)-imtophat(imadjust(I2),se)})
% figure
% montage({I2,medfilt2(I2),imbinarize(medfilt2(I2))})

figure
% montage({I1,adaptthresh(I1),I1-uint8(adaptthresh(I1,'NeighborhoodSize',15)*255),imbinarize(I1-uint8(adaptthresh(I1,'NeighborhoodSize',15)*255))})
local_T = uint8(adaptthresh(I1,'NeighborhoodSize',9)*255);
I3 = I1-local_T;
bw3 = imbinarize(I3);
se = strel('disk',9);
close_bw3 = imclose(bw3,se);
% montage({I1,local_T,I3,bw3,close_bw3}),title('原图-局部异界自适应阈值')
montage({I1,bw3}),title('原图-二值化图')
% 连通域计算/边缘计算/
% L = bwlabel(bw);
[B,L,n,A] = bwboundaries(bw3);
E = edge(bw3,'canny');
figure
montage({I1,bw3,label2rgb(L,@jet,[.5,.5,.5]),E}),title('原图-二值化-伪彩色图-边缘')
%% 统计连通区域的属性
stats = regionprops(L,'all');

%% 模块内函数
function v=minusBk(A,B)
    F = 255;
    ret = A;
    [m,n] = size(A);
    for i=1 : m
        for j=1 : n
            k = setK(B(i,j));
            if B(i,j) < A(i,j)
                ret(i,j) = F - k*(B(i,j)-A(i,j));
                if ret(i,j) < 0.75*F
                    ret(i,j) = 0.75*F;
                end
            else
                ret(i,j) = F;
            end
        end
    end
    v=ret;
end

% get k
function v=setK(e)
if e < 20
    k = 2.5;
elseif e>=20 && e<=100
    k = 1 + ((2.5-1)*(100-e))/80;
elseif e>100 && e<200
    k = 1;
else
    k = 1 + (e-220)/35;
end
v = k;
end