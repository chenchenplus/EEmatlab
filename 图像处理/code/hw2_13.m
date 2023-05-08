load('JpegCoeff.mat');
load('snow.mat');
[DCcodes,ACcodes,H,W] =JPEG(snow,DCTAB,ACTAB,QTAB);
snow_jpeg=anti_JPEG(DCcodes,ACcodes,H,W,DCTAB,ACTAB,QTAB);
figure(1)
imshow(snow_jpeg);
figure(2)
imshow(snow);
disp(PSNR(snow,snow_jpeg));
disp('压缩率：')
disp(8*H*W/(length(DCcodes)+length(ACcodes)));