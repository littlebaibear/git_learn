function Imf=ImageMoveFit(Imag,m,n,RowColFit)
%  h,w
size1=size(Imag);
if RowColFit==0
    avg = mean(Imag,2);
    add_temp = ones(size1(1),(m-1)/2).*avg;
    Imag = cat(2,add_temp,Imag);
    Imag = cat(2,Imag,add_temp);
else
    avg = mean(Imag,1);
    add_temp = ones((m-1)/2,size1(2)).*avg;
    Imag = cat(1,add_temp,Imag);
    Imag = cat(1,Imag,add_temp);
end
size1 = size(Imag);
Imf=zeros(size1(1)+1-m,size1(2)+1-m,n);
InvMat=[2/m 0 0; 0 2/m  0; 0 0 1/m];
ang=pi*(-(m-1):2:(m-1))/m;
sinStep=sin(2*pi/m);
cosStep=cos(2*pi/m);
sinInitial=sin(pi*(-m+1)/m);
cosInitial=cos(pi*(-m+1)/m);
sinEnd=-sinInitial;
cosEnd=cosInitial;
if RowColFit==0 
    for LineNum=1:size1(1)
          x(1:size1(2))=double(Imag(LineNum,1:size1(2)));
          Y=[sum(x(1:m).*sin(ang));sum(x(1:m).*cos(ang));sum(x(1:m))];
          result=InvMat*Y;
          Imf(LineNum,1,1)=result(1);
          Imf(LineNum,1,2)=result(2);
          if n>=3
              Imf(LineNum,1,3)=result(3);
          end
          for fitNo=1:size1(2)-m           
              temp1=Y(1)-x(fitNo)*sinInitial;
              temp2=Y(2)-x(fitNo)*cosInitial;
              Y(1)=temp1*cosStep-temp2*sinStep+x(m+fitNo)*sinEnd;
              Y(2)=temp2*cosStep+temp1*sinStep+x(m+fitNo)*cosEnd; 
              Y(3)=Y(3)-x(fitNo)+x(m+fitNo);
              result=InvMat*Y;
              Imf(LineNum,fitNo+1,1)=result(1);
              Imf(LineNum,fitNo+1,2)=result(2);
              if n>=3
                  Imf(LineNum,fitNo,3)=result(3);
              end
          end
    end 
else
    for colNum=1:size1(2)
      x(1:size1(1))=double(Imag(1:size1(1),colNum));
      Y=[sum(x(1:m).*sin(ang));sum(x(1:m).*cos(ang));sum(x(1:m))];
      result=InvMat*Y;
%           Amp(fitNo)=result(1)*result(1)+result(2)*result(2);
      Imf(1,colNum,1)=result(1);
      Imf(1,colNum,2)=result(2);
      if n>=3
          Imf(1,colNum,3)=result(3);
      end
      for fitNo=1:size1(1)-m         
          temp1=Y(1)-x(fitNo)*sinInitial;
          temp2=Y(2)-x(fitNo)*cosInitial;
          Y(1)=temp1*cosStep-temp2*sinStep+x(m+fitNo)*sinEnd;
          Y(2)=temp2*cosStep+temp1*sinStep+x(m+fitNo)*cosEnd; 
          Y(3)=Y(3)-x(fitNo)+x(m+fitNo);
           result=InvMat*Y;
%           Amp(fitNo)=result(1)*result(1)+result(2)*result(2);
         Imf(fitNo,colNum,1)=result(1);
              Imf(fitNo+1,colNum,2)=result(2);
          if n>=3
              Imf(fitNo+1,colNum,3)=result(3);
          end
      end
     end
end  


