load('hall.mat');
testpic=double(hall_gray(1:60,1:60))-128;%选取测试图像左上角
B=dct2(testpic);
B_90=rot90(B);
B_180=rot90(B,2);
A1=myidct2(B')+128;%转置
A2=myidct2(B_90)+128;%旋转90度
A3=myidct2(B_180)+128;%旋转180度
figure(1)
imshow(uint8(A1));%转置后逆变换的图像
figure(2)
imshow(uint8(A2));%系数矩阵旋转90度后逆变换的图像
figure(3)
imshow(uint8(A3));%系数矩阵旋转180度后逆变换的图像
figure(4)
imshow(uint8(testpic+128));%原图