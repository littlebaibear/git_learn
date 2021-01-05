clear
close all
% bg = imread('D:\boli_defect\imgs\use_MVS\12.28\无玻璃.bmp');
% I=imread('D:\boli_defect\imgs\use_MVS\12.28\20000_0.bmp');
% I = I-bg;%背景去除

I = imread('D:\boli_defect\imgs\use_MVS\12.25\清理后加上下套筒_unknow.bmp');
% I=imread('D:\boli_defect\matlab_code\顶冒大津法二值化\cnr(对比度)计算\roi2.bmp');
% figure,imshow(I)
I1=rgb2gray(I);
figure,imshow(I1);
k = 1;
m = 2*k+1;
% figure,plot(I1(818,:,:))
% hold on
disp('移动正弦拟和')
tic
NewI=ImageMoveFit(I1,m,3,0);
toc

% 交变能量组
NewISquare=(NewI(:,:,1).^2+NewI(:,:,2).^2);
StandError=std(NewISquare(:));
Thresh3Square=(NewISquare>StandError*3)*0.5;
Thresh6Square=(NewISquare>StandError*6);
figure('Name','3σ'),imshow(Thresh3Square)
% figure('Name','6σ'),imshow(Thresh6Square)


%% 缺陷图
imagSize=size(Thresh3Square);
DefectImage=(Thresh3Square<0.5)*0.5;
BrightOrDark=0;
for i=1:imagSize(1)
    FirstOrSecondZero=0;
    for j=1:imagSize(2)-1
        if Thresh3Square(i,j)==0.5
             DefectImage(i,j)=0.5; 
           if NewI(i,j,2)*NewI(i,j+1,2)<=0%cos图变化的点,即最大最小值交替点
               if FirstOrSecondZero==0    %StartPos
                   FirstOrSecondZero=1; 
                   if NewI(i,j,2)>NewI(i,j+1,2)%最大值在前,则为亮斑
                       BrightOrDark=0;
                   else%否则为暗斑
                       BrightOrDark=1;
                   end
               else                       %EndPos
                   FirstOrSecondZero=0;
               end                
           end           
        end      
        if FirstOrSecondZero==1
               DefectImage(i,j)= BrightOrDark;
               if (BrightOrDark==1&&NewI(i,j+1,2)<0)||(BrightOrDark==0&&NewI(i,j+1,2)>0)%如果最后一个暗斑点之后的一个点接一个cos图的正值,终止这个缺陷,跟上面的if是同步的
                  FirstOrSecondZero=0;                  
               end
        end
    end  
end

Row=825;
figure('Name','缺陷图'),imshow(DefectImage)
[B,L,n,A] = bwboundaries(Thresh3Square);
figure,imshow(label2rgb(L,@jet,[.5,.5,.5]))
% figure('Name','能量图'),plot(NewISquare(Row,:))
% xlim([350,550])
% plot(ThreshSquare(825,:))
% hold on
% plot(Thresh6Square(825,:))

% figure('Name','差分组\拟合组'),plot(NewI(825,:,1),'r')
% hold on
% plot(NewI(825,:,2),'c')
% legend('sin','cos')

% figure,
% plot(Thresh3Square(Row,:)*30)
% hold on
% plot(Thresh6Square(Row,:)*30)

