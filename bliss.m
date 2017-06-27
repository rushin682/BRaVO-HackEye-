I=imread('1.jpg'); %read an image
I=rgb2gray(I); %convert rgb to grey 320x320 image
I = double(I); % to convert from int to double
imshow(I)
[m,n]=size(I); % size of the image

counter=1;

blockmeans = zeros(6400,1); % means of the individual 4x4 matrices

totalsum = 0;% total sum of the means of 4x4 matrix
sum4 = 0;% sum of the considered 4x4 matrix 

for i=1:4:320 % to traverse in rows 
    
    
    for j=1:4:320 % to traverse in coloumns
        
        for k=1:4 % to traverse in each 4x4 considered matrix 
            for l=1:4
                sum4=sum4+I(i+k-1,j+l-1); % sum of 4x4 matrix
%                 disp(I(i+k-1,j+l-1));
            end
            
        end
        
        blockmeans(counter) = sum4/16;% store 4x4 mean of all matrices in an array
        sum4=0; % update the sum 
        counter = counter+1; % update the counter
    end
    
    
end
       for l=1:6400
       totalsum = totalsum + blockmeans(l); % to calculate means of means
       end

        totalmean = totalsum/6400;

        diffsum = 0;
        %standard deviation calculation
        for i=1:6400
          diffsum = diffsum + (blockmeans(i)-totalmean)^2; 
            
        end
        
        stdev = sqrt(diffsum/6400);
        %standard deviation calculation
        
        %plotting standard deviation and mean
        
        x = [0:1:255];
        norm = normpdf(x,totalmean,stdev);
        plot (x, norm)


    

