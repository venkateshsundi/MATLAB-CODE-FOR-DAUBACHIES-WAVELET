clc;
close all;
clear all;
x = double(imread('cameraman.tif'));
[m,n]=size(x);
for i=1:1:m
   for j =1:1:n/2
      if j<n/2
        p(i,j)=(x(i,2*j)+x(i,2*j+2))/2;
        d(i,j)=x(i,2*j-1)-p(i,j);
    else
        p(i,j)=x(i,2*j);
        d(i,j)=x(i,2*j-1)-p(i,j);
    end
end

for j =1:1:n/2
    if j<2
        u(i,j)=d(i,j)/2;
        s(i,j)=x(i,2*j)+u(i,j);
    else
        u(i,j)=(d(i,j-1)+d(i,j))/4;
        s(i,j)=x(i,2*j)+u(i,j);
    end
end
s = round(s);
d = round(d);
%inverse
for j=1:1:n/2
    if j<2
        i_u(i,j)=d(i,j)/2;
        y(i,2*j) = s(i,j)-i_u(i,j);
    else
        i_u(i,j)=(d(i,j-1)+d(i,j))/4;
        y(i,2*j) = s(i,j)-i_u(i,j);
    end    

end
for j =1:1:n/2
    if j<n/2
        i_p(i,j)=(y(i,2*j)+y(i,2*j+2))/2;
        y(i,2*j-1)=d(i,j)+i_p(i,j);
    else
        i_p(i,j)=y(i,2*j);
        y(i,2*j-1)=d(i,j)+i_p(i,j);
    end
end
end
figure,imshow(uint8(x)),title('input image')
figure,imshow(uint8(y)),title('output image')
err = imabsdiff(y,x) ;
error = sum(sum(err))/(m*n)
