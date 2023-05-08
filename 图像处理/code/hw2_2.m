testdata=rand(8,8);%随机生成一个8*8矩阵
B1=mydct2(testdata);%自己编写的二维DCT
B2=dct2(testdata);%matlab库函数
B3=mydct2(testdata,10,9);%自己编写的二维DCT，并把输入矩阵resize
testdata(10,9)=0;%把输入矩阵用零填充到10*9
B4=dct2(testdata);%用库函数进行二维DCT