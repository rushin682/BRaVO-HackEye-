% F:\Pictures\Dataset\Testing\L1.jpg
I=imread('F:\Pictures\Dataset\Testing\L1.jpg');
D=imread('F:\Pictures\Dataset\Testing\R1.jpg');
R=rgb2gray(I);
DR=rgb2gray(D);
[L,N] = superpixels(R,20);
[LD,ND] = superpixels(DR,100,'Compactness',20);
disp(L);
disp(N);
% idx=label2idx(L);
% didx=label2idx(LD);
 BW = boundarymask(L);
 DBW = boundarymask(LD);
 imshow(imoverlay(R,BW,'cyan'),'InitialMagnification',67)
 %figure
 %imshow(imoverlay(DR,DBW,'red'),'InitialMagnification',67)
% meanMatrixL=zeros(N,1);
% meanMatrixD=zeros(ND,1);
% total=0;
%  for sPixelNumber=1:N   
%      q=idx{sPixelNumber};    
%      %disp(mean);
%      if (sPixelNumber>49 && sPixelNumber<=51)% || (sPixelNumber>39 && sPixelNumber<=41) || (sPixelNumber>59 && sPixelNumber<=61) 
%            meanMatrixL(sPixelNumber)=0;         
%      else 
%            [x,y]=size(R(q));
%            mean=(sum(R(q(:))))/(x*y);  
%            meanMatrixL(sPixelNumber)=mean;
%            total=total+mean;
%      end  
%      
%  end
% finalMean=total/N;
% dev=0;
% for i=1:N
%     sd=meanMatrixL(i)-finalMean;
%     dev=dev+(sd*sd);
% end
% dev=dev/N;
% dev=sqrt(dev);
% disp(finalMean);
% disp(dev);
% sub=finalMean-(dev);
% disp('mu-sigma is as follows');
% disp(sub);
% sup=finalMean+dev;
% 
% x = 0:1:255;
% norm=normpdf(x,finalMean,dev);
% figure
% plot(norm);
% for sPixelNumber=1:ND   
%     q=didx{sPixelNumber};    
%     %disp(mean);
%     [x,y]=size(DR(q));
%     mean=(sum(DR(q(:))))/(x*y);  
%     if (mean<(sub))
%         
%          disp(mean);
%          disp(sPixelNumber);
%     end    
% end
% 
% 
% 
% 
% 
% 
% 
% 
