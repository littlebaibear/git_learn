% https://blog.csdn.net/u013162930/article/details/47755363
clear
close all
I = imread('D:\boli_defect\imgs\use_MVS\12.22\µ×²¿µæÆ¬·´ÉäÈ±ÏİÕÛÉä¹â.bmp');
I = rgb2gray(I);
I2 = uint8(colfilt(I,[31,31],'sliding',@bk));

figure,imshow(I-I2)
figure,imshow(I2)

function v=sauvola(x)
Y=128;
m1= mean(x);                                                        
v2 = double(x(481,:));
s = size(v2);
s1=(1-0.15*(1-std(double(x))/Y));
v3=v2;
for i = 1:s(2)
    if (v2(1,i)>m1(1,i)*s1(1,i))
       v3(1,i)=255;             
    else
       v3(1,i)=0;
    end
end
v = v3;
end

function v=dbg(x)
    N = size(x);                    
    b = sort(x);
    nMin = b(2:7,:);
    v = mean(nMin);
end

function v=bk(x)
    N = size(x);                    
    b = sort(x);
    nMax = b((N(1)-47) : (N(1)-1),:);
    v = mean(nMax);
end

function v=minusBk(A,B)
    F = 255;
    ret = A;
    [m,n] = size(A);
    for i=1 : m
        for j=1 : n
            k = setK(B(i,j));
            if B(i,j) > A(i,j)
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