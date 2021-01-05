init=imread('D:\MyDocuments\picture analysis\lab three\41524617\1.jpg');  %读入图片
G=rgb2gray(init);%转换成灰度图
subplot(521) ,  imshow(init),  title('原图');
subplot(522) ,  imshow(G),  title('原灰度图');
%radon变换实现图像矫正  
E=edge(G);  
theta=1:180;  
[R,xp]=radon(E,theta);  
[E,J]=find(R>=max(max(R)));%记录角度  
Q=90-J;  %求出倾斜角
I=imrotate(G,Q,'bilinear','crop');  %旋转矫正
subplot(512) ,  imshow(I),  title('矫正后的图像');
%otsu阈值分割
bw=graythresh(I); %自动获取合适阈值
new=im2bw(I,bw);%进行阈值分割
subplot(513) ,  imshow(new),  title('分割出来的图形')
%闭运算降噪
newI = bwmorph(new,'close');
subplot(514) ,imshow(newI),title('闭运算降噪后的图像');
%图像叠加&计算面积
newII = I;
I3(:,:,1)=I;
I3(:,:,2)=I;
I3(:,:,3)=I;
count=0;
for i = 1:400
    for j = 1:800
        if(newI(i,j)==0)
            newII(i,j) = 0; %将中间残缺部分变成纯黑色
        end
        if(I(i,j)-newII(i,j)~=0) %改变值的部分就是中间残缺
            count=count+1;    %对残缺进行计算求面积和标记为红色
            I3(i,j,1)=255;
            I3(i,j,2)=0;
            I3(i,j,3)=0;
        end
    end
end
mianji =count ;
subplot(515),imshow(I3),title('分割后添加到原图');
%计算缺陷面积
%输出图像
imwrite(newI,'分割.jpg');
imwrite(I3,'分割后叠加到原图.jpg');