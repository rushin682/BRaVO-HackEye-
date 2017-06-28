import cv2
import numpy as np
imo=cv2.imread('3.jpg')
cv2.imshow("imo",imo)
imog=cv2.cvtColor(imo,cv2.COLOR_BGR2GRAY)
x=0

ret,threshimog = cv2.threshold(imog,40,255,cv2.THRESH_TOZERO)
cv2.imshow("threshimoga",threshimog)
print(imog.size)
for i in range(320):
    for j in range(320):
        x=x+threshimog[i][j]
    if(x>30000):
        for o in range(320):
            if(o%2==0):
                threshimog[i][o]=0
        blur = cv2.GaussianBlur(threshimog,(1,319),0)
    x=0

mask1=cv2.subtract(threshimog,blur)
mask=cv2.add(mask1,blur)
mask=cv2.addWeighted(mask1,0.8,mask,0.3,0)
masky=cv2.medianBlur(mask,3)
masky=cv2.addWeighted(masky,1.2,mask,0.6,0)
cv2.imshow("final",masky)

cv2.waitKey(0)

