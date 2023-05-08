load('hall.mat');
testpic=hall_gray(10:17,20:27);%选取测试图像中8*8的一块
A1=dct2(testpic);%直接对原图像中的一块进行二维DCT变换
preproc=dct2(128*ones(8));%得到变换域需要减去的矩阵
A1=A1-preproc;
A2=dct2(testpic-128);%预处理后进行二维DCT变换