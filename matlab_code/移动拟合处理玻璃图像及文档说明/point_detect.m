function class = point_detect(gray_mean,h_w_ratio,circularity) 
if gray_mean >T2
    class = 3;
else
    if h_w_ratio>=T3 &&  circularity<=T5
        class = 1;
    else
        class= 2;
    end
end