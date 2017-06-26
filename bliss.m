I=imread('1.jpg');
I=rgb2gray(I);
I = double(I);
imshow(I)
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
        
        x = [0:1:255];
        norm = normpdf(x,totalmean,stdev);
                          
        
        plot (x, norm)


    

