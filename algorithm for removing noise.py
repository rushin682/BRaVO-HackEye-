import cv2
import numpy as np
imo=cv2.imread('3.jpg')
cv2.imshow("imo",imo)
imog=cv2.cvtColor(imo,cv2.COLOR_BGR2GRAY)
x=0
kernel=np.ones((3,3),np.uint8)

ret,threshimog = cv2.threshold(imog,10,255,cv2.THRESH_TOZERO)
cv2.imshow("threshimoga",threshimog)
print(imog.size)
for i in range(320):
    for j in range(320):
        x=x+threshimog[i][j]
    if(x>30000):
        for o in range(320):
            if(o%2==0):
                threshimog[i][o]=0
        blur = cv2.GaussianBlur(threshimog,(5,5),0)
    x=0

cv2.imshow("threshimog",threshimog)
cv2.imshow("gausianblur",blur)
mask=cv2.subtract(threshimog,blur)
cv2.imshow("mask1",mask)
mask=cv2.add(mask,blur)
mask=cv2.addWeighted(mask,0.5,mask,0.4,0)
cv2.imshow("maskfinal",mask)


cv2.waitKey(0)
