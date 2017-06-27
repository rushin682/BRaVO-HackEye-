cd /Users/Dave/Documents/MATLAB/IMAGE_PROCESSING/
I0 = imread('P913786_20160811_153834_Angio (2)_L_001.jpg');
I = rgb2gray(I0); 
figure(1)
imshow(I) 
%Loading images, conversion to grayscale, displayed to confirm.

figure(2)
imhist(I)
%Image Histogram to find distribution of intensity levels

% I2 = histeq(I);
% figure(3)
% imshow(I2)

% figure(4)
% imhist(I2)

F = fft2(I);
figure(3)
imshow(F, [])
%Fast Fourier Transform to take the image into the frequency spectrum 
F = fftshift(F);
F1 = abs(F);
% F1 = log(F1);
% F = mat2gray(F);

figure(4)
imshow(F, [])

figure(5)
imshow(F1, [])



[m,n] = size(I);

%% Ideal Band Reject Filter
myfilter = ones(m,n);

bandwidth = 20;
cutoff = 100;

LL = cutoff - bandwidth/2;
UL = cutoff + bandwidth/2;

for i=1:m-1
    for j=1:n-1
        
        dist = sqrt((i-m/2)^2 + (j-n/2)^2);
        
        if (LL<=dist) && (dist<=UL)
            myfilter(i,j) = 0;
        end
    end
    
end

G = myfilter.*F;
g1=abs(ifft2(G));

figure(7)
imshow(g1,[])
title('Ideal Band-Reject Filter')

figure(99)
imshow(mat2gray(myfilter))
title('Ideal Bandreject filter')


%%Butterworth

myfilter1 = ones(m,n);

bworder = 2;

bandwidth1 = 20;
cutoff1 = 100;

for i=1:m-1
    for j=1:n-1
        
        dist = sqrt((i-m/2)^2 + (j-n/2)^2);
            
        myfilter1(i,j) = 1/(1 + (((dist*bandwidth1)/(dist^2 - cutoff1^2))^(2*bworder)));
    end
end
    
     G2 = myfilter1.*F;
g2=abs(ifft2(G2));

% figure(9)
% plot(myfilter)

figure(8)
imshow(g2,[])
title('Butterworth Band-Reject Filter')
 
figure(100)
imshow(mat2gray(myfilter1))
title('Butterworth Bandreject filter')

%%Gaussian

myfilter2 = ones(m,n);

bandwidth2 = 20;
cutoff2 = 100;

for i=1:m-1
    for j=1:n-1
        
        dist = sqrt((i-m/2)^2 + (j-n/2)^2);
            myfilter2(i,j) = (1 - exp(-(((dist^2 - cutoff2^2)/(dist*bandwidth2))^2)));
    end
end
    
     G3 = myfilter2.*F;
g3=abs(ifft2(G3));

% figure(10)
% imshow(g3, [])
% title('Gaussian Band-Reject Filter')
% 
% figure(101)
% imshow(mat2gray(myfilter2))
% title('Gaussian Bandreject filter')

% display(min(abs(F)))
% 
% display(max(abs(F)))
