load('hall.mat');
[h,w,~]=size(hall_color);
n=4;%设置黑白格的边长
I1=(checkerboard(n,h/(2*n),w/(2*n))> 0.5);%用checkerboard函数得到黑白灰棋盘
                                          %用>0.5的条件转化为黑白棋盘
I1=cat(3,I1,I1,I1);%I1原来只有一页，为了和全彩图运算拼接成三页
I2=hall_color;
I2(I1==0)=0;%彩色图对应棋盘黑色位置的数值设置为零，也就是黑色
imshow(I2);
imwrite(I2,"1_2b.png");