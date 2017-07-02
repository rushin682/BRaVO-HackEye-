clear;clc;
cd1=cd;
clear cd;
cd('C:\Users\Nihanth Adina\Documents\MATLAB\EYE\Diseased\')%to read the images from a folder
folder_files=dir;
stdev=0;%standard deviation of each individual image w.r.t its mean
diffsum=0;%used as a summer to calculate the standard deviation
totalmean=0;%mean of each image

%     means=zeros(500,1);
%     sde=zeros(500,1);
cout=1;
a=1;
c=1;
cb=1;
disp(folder_files);
p=zeros(4,1);
for j=1:length(folder_files)
    mr_no=folder_files(j).name;
%     disp(mr_no);
    path=strcat('C:\Users\Nihanth Adina\Documents\MATLAB\Eye\Diseased\',mr_no);
    clear cd;
    cd (path);
    Files= dir('*.jpg');
    
    %  bwratio=0;
    %b{j}=mr_no;
    
    %       A(j,1)=mr_no;
    p(a)=length(Files);
%     disp(length(Files));
    a=a+1;
    for k=1:length(Files)
%         stdev = 0;
%         diffsum=0;
%         totalmean=0;
        FileNames=Files(k).name;
        
        I = imread(FileNames);
%         I = rgb2gray(I);
        I = double(I);
        
        [m,n]=size(I);
        
        counter=1;
        
        blockmeans = zeros(6400,1);
        
        totalsum = 0;
        sum4 = 0;
        
        for i=1:4:320
            
            
            for j=1:4:320
                
                for k=1:4
                    for l=1:4
                        sum4=sum4+I(i+k-1,j+l-1);
                        %                 disp(I(i+k-1,j+l-1));
                    end
                    
                end
                
                blockmeans(counter) = sum4/16;
                sum4=0;
                counter = counter+1;
            end           
            
        end
        for l=1:6400
            totalsum = totalsum + blockmeans(l);
        end
        
        totalmean = totalsum/6400;
        
        diffsum = 0;
        
        for i=1:6400
            diffsum = diffsum + (blockmeans(i)-totalmean)^2;
            
        end
        
        stdev = sqrt(diffsum/6400);
        %to find the mean of pixels intensity of each image
        means(c) = totalmean;
        %to find the standard deviation of each image
        sde(cb) = stdev;
        c=c+1;
        cb=cb+1;
        stdev=0;
        totalmean=0;
        diffsum=0;
        
        
      

     end
%         clear cd;
%         cd('C:\Users\Nihanth Adina\Documents\MATLAB\EYE\')
%         xlswrite('da.xlsx',means,cout);
%         xlswrite('da.xlsx',sde,cout+1);
%         clear cd;
%         cout=cout+2;
        
    
end
flag=1;
blah=1;
sum=zeros(4,1);
%as the images are taken the means of each image are saved, now according
%to the number of images the standard deviation and mean is differentiated
%as 4 arrays 
%--------------------------------------------------------------------------
%to find out the global mean of each layer
for i=3:6
    k=p(i);
    m=i-2;
    for j=1:k
        
        if blah==1
            means1(j)=means(flag);
            sum(m)=sum(m)+means1(j);
            sde1(j)=sde(flag);
        end
        if blah==2
            means2(j)=means(flag);
            sum(m)=sum(m)+means2(j);
            sde2(j)=sde(flag);
        end
        if blah==3
            means3(j)=means(flag);
            sum(m)=sum(m)+means3(j);
            sde3(j)=sde(flag);
        end
        if blah==4
            means4(j)=means(flag);
            sum(m)=sum(m)+means4(j);
            sde4(j)=sde(flag);
        end
        
        flag=flag+1;
    end
    sum(m)=sum(m)/p(i);%global mean of all the layers 1,2,3,4.
    blah=blah+1;
    
end
counter=counter-1;

flag=1;
blah=1;
%to find the global standard deviation of each layer;
sd=zeros(4,1);
for i=3:6
    k=p(i);
    m=i-2;
    for j=1:k
        
        if blah==1
         sd(m)= sd(m)+ (means1(j)-sum(blah))^2;
         
        end
        if blah==2
          sd(m)= sd(m)+ (means2(j)-sum(blah))^2;
        end
        if blah==3
            sd(m)= sd(m)+ (means3(j)-sum(blah))^2;
        end
        if blah==4
            sd(m)= sd(m)+ (means4(j)-sum(blah))^2;
        end
        
        flag=flag+1;
    end
    sd1(blah) = sqrt(sd(blah)/p(i));
    blah=blah+1;
    
end
% x = [0:1:255];
% norm = normpdf(x,sum(1),sd1(1));
% plot(x,norm);

% %---------------------Layer1---------------------------------------------------------------------------------------------------------------------------------------
% % to only obtain blood vessels pixels 
% pix=sum(1)+sd1(1);
%  I = imread('1.jpg');
% %  imshow(I);
% %  I = rgb2gray(I);
%  I = double(I);
%  count2=0;
%  count1=0;
%  for i=1:320
%      for j=1:320
%          if I(i,j)>=sum(1)
%               I(i,j)=255;
%              count1=count1+1;
%          end
%          if I(i,j)<=sum(1)
%             I(i,j)=0;
%             count2=count2+1;
%          end
%      end
%  end
%      vd=count1/102400;
%      vd1=count2/102400;
%      BW = im2bw(I,0.4);
%     
%      CC = bwconncomp(BW);
%     numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idx] = max(numPixels);
% BW(CC.PixelIdxList{idx}) = 1;
% figure(1)
% imshow(BW);
%      figure(2)
%      imshow(I);
%      
     
% imshow(I);
 
 
%-------------------------Layer2-------------------------------------------------
% to only obtain blood vessels pixels 
% pix=sum(2)+sd1(2);
%  I = imread('2.jpg');
% %  imshow(I);
%  I = rgb2gray(I);
%  I = double(I);
%  
%  count1=0;
%  for i=1:320
%      for j=1:320
%          if I(i,j)<pix
%             I(i,j)=0;
%          end
%      end
%  end
% 
%  imshow(I);
% count=0;
% for k=1:p(3)
%     
% clear cd;
% cd ('C:\Users\Nihanth Adina\Documents\MATLAB\Eye\Diseased\Layer1\');
% files=dir('*.jpg');
% I=imread(files(k).name);
%   for i=1:320
%      for j=1:320
%          if I(i,j)<=sum(1)+sd1(1)
%             I(i,j)=0;
%          else
%              I(i,j)=255;
%             
%          end
%      end
%   end
%   count=count+1;
%   clear cd; 
%  cd ('C:\Users\Nihanth Adina\Documents\MATLAB\Eye\Diseased\');
%  imwrite(I,sprintf('%d.jpg',k))
%end 
%---------------------------------------------------------------------------------------------------------------------------------------------------------
%w.r.t each image the valscular density is found out using the below code
%by taking 80x80 matrices
%---------------------------------------------------------------------------
%now the global mean of vascular density w.r.t each image is found out

po=p(4)*16;
st=zeros(po,1);
vas=0;
c=0;       
count=0;
for k=1:p(4)
    
clear cd;
cd ('C:\Users\Nihanth Adina\Documents\MATLAB\Eye\Diseased\Layer2\');
files=dir('*.jpg');
I=imread(files(k).name);

pix=sum(2)+sd1(2);
% I=rgb2gray(I);
I=double(I);

for  i=1:80:320
    for  j=1:80:320
%         m=0;
        for  k=1:80
            for l=1:80
%                 m=m+1;
                if i+k-1==321 | j+l-1==321
                    break;
                end
                if I(i+k-1,j+l-1)>=pix
%                     co=co+1;
                vas=vas+1;
                end
            end
        end
%         disp(m);
%         disp(vas);
        c=c+1;
        st(c)=vas/6400;
        vas=0;
    end
    
        
    
end
end
c=0;
summer=0;
pi=p(4)
for i=1:po
    
    summer=summer+st(i);
end
summer=summer/po;
sm=0;
for i=1:po
    sm=sm+(st(i)-summer)^2;
end
sm=sqrt(sm/po);

%the above code gives us the global mean and global standard deviation of vascular density
%----------------------------------------------------------------------------
%to take a new image and classify it a diseased or non diseased
% x = [0:0.001:1];
% norm = normpdf(x,summer,sm);
% plot(x,norm);
% h=kstest(norm)
clear cd;
cd('C:\Users\Nihanth Adina\Documents\MATLAB\EYE\');
I=imread('d.jpg');
counterr=0;
vas1=0;
c1=0;
pix1=sm+summer;
for  i=1:80:320
    for  j=1:80:320
        %         m=0;
        for  k=1:80
            for l=1:80
                %                 m=m+1;
                if i+k-1==321 | j+l-1==321
                    break;
                end
                if I(i+k-1,j+l-1)>=pix1
                    %                     co=co+1;
                    vas1=vas1+1;
                end
            end
        end
        %         disp(m);
        %         disp(vas);
        c1=c1+1;
        st1(c1)=vas1/6400;
        vas1=0;
        
        if st1(c1)>pix1
            counterr=counterr+1;
             end
        end
        
end
    sio=0;
for i=1:16
    sio=sio+st1(i)*6400;
end
sio=sio/102400;
