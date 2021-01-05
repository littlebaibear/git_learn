function result_cnr = cnr(noise_region,roi1,roi2,roi3,roi4)
%myCnr Summary of this function goes here  
%   img_den is a noise/denoise image  
%   noise_region is the selected regions of interest and of background noise region
%   roi1,roi2,roi3,roi4 are four interest Regions
%   the function will return the result_cnr of the image  
%   tip: this function need five selected regions from the image you want to evaluate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%author:ebowtang
%author blog:http://blog.csdn.net/ebowtang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
noise_region=double(noise_region);
roi1=double(roi1);
roi2=double(roi2);
roi3=double(roi3);
roi4=double(roi4);
 
ub=mean2(noise_region);
u1=mean2(roi1);
u2=mean2(roi2);
u3=mean2(roi3);
u4=mean2(roi4);
 
varb=std2(noise_region);varb=varb*varb;
var1=std2(roi1);var1=var1*var1;
var2=std2(roi2);var2=var2*var2;
var3=std2(roi1);var3=var3*var3;
var4=std2(roi1);var4=var4*var4;
 
cnr1=10*log((u1-ub)/sqrt(var1+varb));
cnr2=10*log((u2-ub)/sqrt(var2+varb));
cnr3=10*log((u3-ub)/sqrt(var3+varb));
cnr4=10*log((u4-ub)/sqrt(var4+varb));
 
result_cnr=(cnr1+cnr2+cnr3+cnr4)/4;
