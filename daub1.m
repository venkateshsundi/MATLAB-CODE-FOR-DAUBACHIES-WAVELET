clc;
close all;
clear all;
 x = imread('cameraman.tif');
 x = double(x(153,101:108))
%x=[1 201 202 204];
%x = [201 201 200 190 5 2]
% x =[14 13 12 13 12 101 192 192]
n = length(x);
%predict
for k =1:1:n/2
    if k<n/2
        p(k)=(x(2*k)+x(2*k+2))/2;
        d(k)=x(2*k-1)-p(k);
    else
        p(k)=x(2*k);
        d(k)=x(2*k-1)-p(k);
    end
end


%update
for k =1:1:n/2
    if k<2
        u(k)=d(k)/2;
        s(k)=x(2*k)+u(k);
    else
        u(k)=(d(k-1)+d(k))/4;
        s(k)=x(2*k)+u(k);
    end
end

d = round(d);
s = round(s);

%% inverse

for k=1:1:n/2
    if k<2
        i_u(k)=d(k)/2;
        y(2*k) = s(k)-i_u(k);
    else
        i_u(k)=(d(k-1)+d(k))/4;
        y(2*k) = s(k)-i_u(k);
    end    

end

for k =1:1:n/2
    if k<n/2
        i_p(k)=(y(2*k)+y(2*k+2))/2;
        y(2*k-1)=d(k)+i_p(k);
    else
        i_p(k)=y(2*k);
        y(2*k-1)=d(k)+i_p(k);
    end
end

y = round(y)  ;
error = y-x

