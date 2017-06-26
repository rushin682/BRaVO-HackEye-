I=imread('F:\Pictures\Dataset\Testing\R1.jpg');
R=rgb2gray(I);
R=double(R);
[m,n]=size(R);
disp(m);
disp(n);
imshow(R);
x=3;y=3;
% selfFilter=ones(x,y);
cumulativeMean=zeros(m/x,n/y);
cumulativeDeviation=zeros(m/x,n/y);
% test=zeros(m,n);
% sumTotal=0;
% s=1;t=1;
% sum=0;
for i=2:3:((m/x)-1)
    for j=2:3:((n/y)-1)
        cumulativeMean(i-1,j-1)=(R(i-1,j-1)+R(i-1,j)+R(i-1,j+1)+R(i,j-1)+R(i,j)+R(i,j+1)+R(i+1,j-1)+R(i+1,j)+R(i+1,j+1))/9;
    end
end


