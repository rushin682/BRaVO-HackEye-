I=imread('F:\Pictures\Dataset\Testing\R1.jpg');
R=rgb2gray(I);
T=imbinarize(R);
% figure
% imshow(T);
R=im2double(R);
N=imcomplement(R);
% figure
% subplot(2,2,1);
% imshow(N);
title('Original Image');

se=strel('disk',2,4);
imd=imerode(N,se);
imd=imdilate(imd,se);
% subplot(2,2,2);
% imshow(imd);

imd=imgaussfilt(imd);
b2=imbinarize(imd,0.55);
% subplot(2,2,3);
% imshow(b2);

final=imcomplement(b2);
% subplot(2,2,4);
% imshow(final);

final=final&T;

imshow(final);