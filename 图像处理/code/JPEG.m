function [DC_code,AC_code,H,W] =JPEG(pic,DCTAB,ACTAB,QTAB)
[H,W]=size(pic);
pic_DCT=picprocess(pic,QTAB);%实现图像分块，二维DCT，量化和Zig-Zag扫描
DC_code=DCcode(pic_DCT(1,:),DCTAB);%生成DC码流
AC_code=ACcode(pic_DCT(2:size(pic_DCT,1),:),ACTAB);%生成AC码流
end