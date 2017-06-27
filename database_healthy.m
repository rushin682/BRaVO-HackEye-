cd1=cd;
clear cd;
cd('C:\Users\Nihanth Adina\Documents\MATLAB\EYE\Non-Deseased\')
folder_files=dir;
stdev=0;
diffsum=0;
totalmean=0;

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
    disp(mr_no);
    path=strcat('C:\Users\Nihanth Adina\Documents\MATLAB\Eye\Non-Deseased\',mr_no);
    clear cd;
    cd (path);
    Files= dir('*.jpg');
    
    %  bwratio=0;
    %b{j}=mr_no;
    
    %       A(j,1)=mr_no;
    p(a)=length(Files);
    disp(length(Files));
    a=a+1;
    for k=1:length(Files)
        stdev = 0;
        diffsum=0;
        totalmean=0;
        FileNames=Files(k).name;
        
        I = imread(FileNames);
        I = rgb2gray(I);
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
        
        means(c) = totalmean;
        sde(cb) = stdev;
        c=c+1;
        cb=cb+1;
        
        
      

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
