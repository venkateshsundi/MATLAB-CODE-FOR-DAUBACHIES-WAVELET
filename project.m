clc;
close all;
clear all;
a=imread("/home/venkatesh/Downloads/lena.jpeg");
imshow(a),title('input image');
x=double(a([1:220],[1:220]));
%%rows
[m,n]=size(x);
for i=1:1:m
   for j =1:1:n/2
      if j<n/2
        p(i,j)=(x(i,2*j)+x(i,2*j+2))/2;
        y1(i,2*j-1)=x(i,2*j-1)-p(i,j);
    else
        p(i,j)=x(i,2*j);
        y1(i,2*j-1)=x(i,2*j-1)-p(i,j);
    end
end

for j =1:1:n/2
    if j<2
        u(i,j)=y1(i,2*j-1)/2;
        y1(i,2*j)=x(i,2*j)+u(i,j);
    else
        u(i,j)=(y1(i,2*j-1)+y1(i,2*j-3))/4;
        y1(i,2*j)=x(i,2*j)+u(i,j);
    end
end
end
y1=round(y1);
figure,imshow(uint8(y1)),title('after 1D-DWT-image');

%transpose
cx = y1.';
%columns

[m,n]=size(cx);
for i=1:1:m
   for j =1:1:n/2
      if j<n/2
        p(i,j)=(cx(i,2*j)+cx(i,2*j+2))/2;
        y2(i,2*j-1)=cx(i,2*j-1)-p(i,j);
    else
        p(i,j)=cx(i,2*j);
        y2(i,2*j-1)=cx(i,2*j-1)-p(i,j);
    end
end

for j =1:1:n/2
    if j<2
        u(i,j)=y2(i,2*j-1)/2;
        y2(i,2*j)=cx(i,2*j)+u(i,j);
    else
        u(i,j)=(y2(i,2*j-1)+y2(i,2*j-3))/4;
        y2(i,2*j)=cx(i,2*j)+u(i,j);
    end
end
end
y2=round(y2);
figure,imshow(uint8(y2.')),title('after 2D-DWT-image');


%inverse
[m,n]=size(y2);
for i=1:1:m
for j=1:1:n/2
    if j<2
        i_u(i,j)=y2(i,2*j-1)/2;
        y3(i,2*j) = y2(i,2*j)-i_u(i,j);
    else
        i_u(i,j)=(y2(i,2*j-1)+y2(i,2*j-3))/4;
        y3(i,2*j) = y2(i,2*j)-i_u(i,j);
    end    

end
for j =1:1:n/2
    if j<n/2
        i_p(i,j)=(y3(i,2*j)+y3(i,2*j+2))/2;
        y3(i,2*j-1)=y2(i,2*j-1)+i_p(i,j);
    else
        i_p(i,j)=y3(i,2*j);
        y3(i,2*j-1)=y2(i,2*j-1)+i_p(i,j);
    end
end

end
y3=y3.';
figure,imshow(uint8(y3)),title('after INVERSE 1D-DWT-image');

[m,n]=size(y3);
for i=1:1:m
for j=1:1:n/2
    if j<2
        i_u(i,j)=y3(i,2*j-1)/2;
        y4(i,2*j) = y3(i,2*j)-i_u(i,j);
    else
        i_u(i,j)=(y3(i,2*j-1)+y3(i,2*j-3))/4;
        y4(i,2*j) = y3(i,2*j)-i_u(i,j);
    end    

end
for j =1:1:n/2
    if j<n/2
        i_p(i,j)=(y4(i,2*j)+y4(i,2*j+2))/2;
        y4(i,2*j-1)=y3(i,2*j-1)+i_p(i,j);
    else
        i_p(i,j)=y4(i,2*j);
        y4(i,2*j-1)=y3(i,2*j-1)+i_p(i,j);
    end
end

end

figure,imshow(uint8(y4)),title('after INVERSE 2D-DWT-image/OUTPUT IMAGE');
MEAN_ERROR =sum(sum(uint8(y4)-x))/(m*n)