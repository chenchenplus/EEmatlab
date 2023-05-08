load('JpegCoeff.mat');
load('hall.mat');
pic=hall_gray;
[DCcodes,ACcodes,H,W] =JPEG(pic,DCTAB,ACTAB,0.5*QTAB);
pic_jpeg=anti_JPEG(DCcodes,ACcodes,H,W,DCTAB,ACTAB,0.5*QTAB);
figure(1)
imshow(pic_jpeg);
figure(2)
imshow(hall_gray);
disp(PSNR(hall_gray,pic_jpeg));
