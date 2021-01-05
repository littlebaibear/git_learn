# -- coding: utf-8 --
import cv2
import matplotlib.pyplot as plt
import numpy as np

img = cv2.imread(r'D:\boli_defect\imgs\IMGS\roi_bd.bmp')
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
plt.subplot(131)
plt.imshow(gray_img, cmap=plt.cm.gray)
plt.title('gray')
plt.axis('off')

ret, bin_img = cv2.threshold(
    gray_img, 0, 255, cv2.THRESH_BINARY+cv2.THRESH_OTSU)
plt.subplot(132)
plt.imshow(bin_img, cmap=plt.cm.gray)
plt.title('bin')


kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5))
tophat = cv2.morphologyEx(gray_img, cv2.MORPH_TOPHAT, kernel)
plt.subplot(133)
plt.imshow(tophat, cmap=plt.cm.gray)
plt.title('tophat')
plt.show()

num, k = cv2.connectedComponents(tophat)
plt.imshow(k, cmap=plt.cm.gray)
plt.show()
# 测试变更
# 测试变更1
# 测试版本2
# 测试版本3
# 测试版本4
# dev分支v5
