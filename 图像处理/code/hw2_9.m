load('hall.mat');
load('JpegCoeff.mat');
pic=hall_gray;
[H,W]=size(pic);
pic_DCT=picprocess(pic,QTAB);%实现图像分块，二维DCT，量化和Zig-Zag扫描
DC_code=DCcode(pic_DCT(1,:),DCTAB);%生成DC码流
AC_code=ACcode(pic_DCT(2:size(pic_DCT,1),:),ACTAB);%生成AC码流
jpegcodes = struct('DC_code',{DC_code},'AC_code',AC_code,'H',H,'W',W);%以结构体形式存入jpegcodes.mat
save 'jpegcodes.mat' jpegcodes