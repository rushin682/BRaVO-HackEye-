clc;
clear all;
close all;
%*---------- Reading image(s) with a specific format -----------*%
% [filename, pathname, filterindex] = uigetfile( ...
% {  '*.dcm','DICOM (*.dcm)'; ...
%    '*.jpg','JPEG (*.jpg)'; ...
%    '*.bmp','Windows Bitmap (*.bmp)'; ...
%    '*.fig','Figures (*.fig)'; ...
%    '*.*',  'All Files (*.*)'}, ...
%    'Choose image(s) to be processed', ...
%    'MultiSelect', 'on');
% 
% if filterindex==0 end
% 
% filename=cellstr(filename);
% rem=filename;
% while true
%     [token, rem] = strtok(rem,'.');
%     if isempty(char(rem)), break; end
% end
% 
% num=numel(token);
% h = waitbar(0,'Loading selected image(s) in progress...');
% for i= 1:num
%     switch(lower(char(token(i))))
%         case 'dcm'
%             J= dicomread(horzcat(pathname,char(filename(i))));
%             if ndims(J) >3
%                Js=squeeze(J);
%                Js1=Js(:,:,1);
%                Js2=Js(:,:,2);
%                Js3=Js(:,:,3);
%                Jc=cat(3,Js1,Js2,Js3);
%                Ig=rgb2gray(Jc);
%                I{i}= Ig;
%              else I{i}= J; end
%             waitbar(i/num)
%         case {'fig','m'}
%             I{i}= load(horzcat(pathname,char(filename(i))));
%             waitbar(i/num)
%         case {'jpg','jpeg','bmp','png','tiff','tif','gif'}
%             J= imread(horzcat(pathname,char(filename(i))));
%             if ndims(J) >2
%                I{i}= rgb2gray(J);
%             else I{i}= J; end
%             waitbar(i/num)
%         otherwise 
%             I{i}= load(horzcat(pathname,char(filename(i))));
%             waitbar(i/num)
%     end        
% end
%close(h);




%Reading the image file
J = imread('C:\Users\HP\Desktop\BRaVO\Healthy\Layer1\final.jpg');
% cd 'C:\Users\HP\Desktop\BRaVO\Healthy\Layer2\final';
% folder_files=dir;
% 


% Files= dir('*.jpg');
   
      

% Vd=zeros(length(Files));
% Vd1=zeros(length(Files));
% 
%       for z=1:length(Files)
%         FileNames=Files(z).name;
%         J = imread(FileNames);

if ndims(J)>2
I{1}= rgb2gray(J);
else I{1}= J; 
end
for j=1:1
[M,N]= size(I{j});



%------- performing non-linear filtering on a varying size pixel block -------%
h = waitbar(0,'Performing 3-D Box Counting...');
for r=5:7
rc = @(x) floor(((max(x)-min(x))/r))+ 1; % non-linear filter
F= colfilt(I{j}, [r r],'sliding', rc);
B{r}= log(double(F * (49/(r^2))));%local fractal dimension.
waitbar(r/6)
end
close(h)

i=log(5:7); % Normalised scale range vector

%------- computing the slope using linear regression -------%
Nxx=dot(i,i)-(sum(i)^2)/3;		%Denominator

h = waitbar(0,'Transforming to FD...');
maxi=-1;
for m = 1:M
    for n = 1:N
        fd{7}(m,n)=B{7}(m,n);
        fd{6}(m,n)=B{6}(m,n);
        fd{5}(m,n)=B{5}(m,n);
%         fd{4}(m,n)=B{4}(m,n);
%         fd{3}(m,n)=B{3}(m,n);
%         fd{2}(m,n)=B{2}(m,n); % Number of boxes multiscale vector
        fd1=[B{7}(m,n), B{6}(m,n), B{5}(m,n)]; %, B{4}(m,n), B{3}(m,n), B{2}(m,n)];
        Nxy=dot(i,fd1)-(sum(i)*sum(fd1))/3; 
        FD{j}(m, n)= (Nxy/Nxx); % slope of the linear regression line         
        
    end
    waitbar(m/M)
end
% maxi2=max(max(fd{2}));
% maxi3=max(max(fd{3}));
% maxi4=max(max(fd{4}));
% maxi5=max(max(fd{5}));
% maxi6=max(max(fd{6}));
% maxi7=max(max(fd{7}));


%Normalizing to get the FD values between 0 and 1 by dividing FD of each
%pixel with the maximum value of FD.
for r=5:7
    
    for m=1:M
        for n=1:N
            fd{r}(m,n)=fd{r}(m,n)/max(max(fd{r}));
            FD{j}(m,n)=FD{j}(m,n)/max(max(FD{j}));
        end
    end 
end    
close(h)
end
% figure(67)
% contour3(fd{5});
% figure(68)
% contour3(fd{6}); 
% figure(69)
% contour3(fd{7});
figure(70)
contour3(FD{1})
%*----------- selecting a Region of Interest & finding corresponding average FD and Lacunarity -----------*%
fdnsum=0;
fdnarea=M*N;
fdno=zeros(3);
FDno=zeros(3);

vessel_Density = zeros(3);
vessel_Density1 = zeros(3);

for k=5:7
    for m=1:M

        for n=1:N
           if fd{k}(m,n)>=0.85
                fdno(k-4)=fdno(k-4)+1;
           end
           if FD{j}(m,n)>=0.9
                FDno(k-4)=FDno(k-4)+1;
           end
            
        end
    end
    vessel_Density(k-4)=fdno(k-4)/fdnarea;
    
    vessel_Density1(k-4)=FDno(k-4)/fdnarea;
end    

disp (vessel_Density(:));


disp (vessel_Density1(:));
% 
% Vd(z) = vessel_Density(2);
% Vd1(z) = vessel_Density1(1);
%  
      
      

% I2 = imbinarize(img);
% 
% figure(80)
% imshow(I2);

% y=colormap(jet(4));
% imwrite(I{1},y,'rgb.jpg','jpg'); % Re-change it to colored one
% figure(1000);
% imshow('rgb.jpg');
% img = imread('rgb.jpg');
% img2 = imbinarize(img); 
% figure(101)
% imshow(img2);





