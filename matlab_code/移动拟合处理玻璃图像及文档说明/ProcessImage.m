clear
close all
% bg = imread('D:\boli_defect\imgs\use_MVS\12.28\�޲���.bmp');
% I=imread('D:\boli_defect\imgs\use_MVS\12.28\20000_0.bmp');
% I = I-bg;%����ȥ��

I = imread('D:\boli_defect\imgs\use_MVS\12.25\������������Ͳ_unknow.bmp');
% I=imread('D:\boli_defect\matlab_code\��ð��򷨶�ֵ��\cnr(�Աȶ�)����\roi2.bmp');
% figure,imshow(I)
I1=rgb2gray(I);
figure,imshow(I1);
k = 1;
m = 2*k+1;
% figure,plot(I1(818,:,:))
% hold on
disp('�ƶ��������')
tic
NewI=ImageMoveFit(I1,m,3,0);
toc

% ����������
NewISquare=(NewI(:,:,1).^2+NewI(:,:,2).^2);
StandError=std(NewISquare(:));
Thresh3Square=(NewISquare>StandError*3)*0.5;
Thresh6Square=(NewISquare>StandError*6);
figure('Name','3��'),imshow(Thresh3Square)
% figure('Name','6��'),imshow(Thresh6Square)


%% ȱ��ͼ
imagSize=size(Thresh3Square);
DefectImage=(Thresh3Square<0.5)*0.5;
BrightOrDark=0;
for i=1:imagSize(1)
    FirstOrSecondZero=0;
    for j=1:imagSize(2)-1
        if Thresh3Square(i,j)==0.5
             DefectImage(i,j)=0.5; 
           if NewI(i,j,2)*NewI(i,j+1,2)<=0%cosͼ�仯�ĵ�,�������Сֵ�����
               if FirstOrSecondZero==0    %StartPos
                   FirstOrSecondZero=1; 
                   if NewI(i,j,2)>NewI(i,j+1,2)%���ֵ��ǰ,��Ϊ����
                       BrightOrDark=0;
                   else%����Ϊ����
                       BrightOrDark=1;
                   end
               else                       %EndPos
                   FirstOrSecondZero=0;
               end                
           end           
        end      
        if FirstOrSecondZero==1
               DefectImage(i,j)= BrightOrDark;
               if (BrightOrDark==1&&NewI(i,j+1,2)<0)||(BrightOrDark==0&&NewI(i,j+1,2)>0)%������һ�����ߵ�֮���һ�����һ��cosͼ����ֵ,��ֹ���ȱ��,�������if��ͬ����
                  FirstOrSecondZero=0;                  
               end
        end
    end  
end

Row=825;
figure('Name','ȱ��ͼ'),imshow(DefectImage)
[B,L,n,A] = bwboundaries(Thresh3Square);
figure,imshow(label2rgb(L,@jet,[.5,.5,.5]))
% figure('Name','����ͼ'),plot(NewISquare(Row,:))
% xlim([350,550])
% plot(ThreshSquare(825,:))
% hold on
% plot(Thresh6Square(825,:))

% figure('Name','�����\�����'),plot(NewI(825,:,1),'r')
% hold on
% plot(NewI(825,:,2),'c')
% legend('sin','cos')

% figure,
% plot(Thresh3Square(Row,:)*30)
% hold on
% plot(Thresh6Square(Row,:)*30)

