function bin_img=adaptive_thresh(img,rate)
imgSize = size(img);
bin_img = zeros(imgSize);
hh = imgSize(1);
ww = imgSize(2);
% »¬´°³ß´ç
% Height = sqrt(hh/ww*(hh+ww));
% Width = ww/hh*Height;
Height = 5;
Width = Height;
% Width = ww/hh*Height;
for h=(1:hh)
    if h==178
        a=1;    
    end
    for w=(1:ww)
        h1=h-floor(Height/2);
        h2=h+floor(Height/2);
        w1=w-floor(Width/2);
        w2=w+floor(Width/2);
        if h1<1
            h1=1;
        end
        if w1<1
            w1=1;
        end
        if h2>imgSize(1)
            h2=imgSize(1);
        end
        if w2>imgSize(2)
            w2=imgSize(2);
        end
        bin_img(h,w) = mean(img(h1:h2,w1:w2),'all');
    end
end
bin_img(img<bin_img*rate)=0;
bin_img(bin_img~=0)=1;
    
