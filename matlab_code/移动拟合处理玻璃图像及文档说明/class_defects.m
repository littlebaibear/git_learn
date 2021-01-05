function class_id = class_defects(stats,L,grayImg)

% 1:划痕,2:点缺陷,3:异物
% 初始化分类指标的值,T1-T8等
num_defects = length(stats);
class_id = zeros(1,num_defects);
for i=1:length(stats)
    h_w_ratio = stats(i).MajorAxisLength/stats(i).MinorAxisLength;
    gray_mean =grayImg(L==1)/stats(i).Area;
    area =stats(i).Area; 
    circularity = stats(i).Circularity;
    p = area/(stats(i).MajorAxisLength^2+stats(i).MinorAxisLength^2)^0.5;

    if h_w_ratio>T7
        class_id(i) = 1;
    elseif area>T6
        class_id(i)=3;
    elseif area<T1
        class_id(i) = point_detect(gray_mean,area,circularity);
    elseif h_w_ratio<T8
        class_id(i) = 3;
    elseif p>4&&gray_mean>72
        class_id(i)=3;
    else
        class_id(i)=1;
    end
end

    