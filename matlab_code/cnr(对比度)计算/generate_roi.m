function positions= generate_roi(origin_img)
% rois{1} = img(823:931,1069:1235);
% rois{2} = img(2615:2659,911:941);
% rois{3}= img(1770:1800,1288:1325);
% rois{4} = img(923:989,783:851);
% rois{5} = img(720:770,1840:1900);



% origin_img = imread([pathname,filename]);
% figure(1);
% imshow(origin_img);

for i=1:5
    h = imrect;
    positions{i} = getPosition(h);
end


