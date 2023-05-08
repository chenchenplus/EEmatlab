load('JpegCoeff.mat');
load('hall.mat');
pic=hall_gray;
%方法1
[DCcodes1,ACcodes1,H1,W1] =JPEGfor3_2(pic,DCTAB,ACTAB,QTAB,1);
data1=DataDecodefor3_2(DCcodes1,ACcodes1,120,168,DCTAB,ACTAB,16,1);
pic_jpeg1=anti_JPEG(DCcodes1,ACcodes1,H1,W1,DCTAB,ACTAB,QTAB);
disp('隐藏方法1 PSNR：');
disp(PSNR(pic,pic_jpeg1));
disp('压缩率');
disp(8*H1*W1/(length(DCcodes1)+length(ACcodes1)));

%方法2
[DCcodes2,ACcodes2,H2,W2] =JPEGfor3_2(pic,DCTAB,ACTAB,QTAB,2);
data2=DataDecodefor3_2(DCcodes2,ACcodes2,120,168,DCTAB,ACTAB,16,2);
pic_jpeg2=anti_JPEG(DCcodes2,ACcodes2,H2,W2,DCTAB,ACTAB,QTAB);
disp('隐藏方法2 PSNR：');
disp(PSNR(pic,pic_jpeg2));
disp('压缩率');
disp(8*H2*W2/(length(DCcodes2)+length(ACcodes2)));

%方法3
[DCcodes3,ACcodes3,H3,W3] =JPEGfor3_2(pic,DCTAB,ACTAB,QTAB,3);
data3=DataDecodefor3_2(DCcodes3,ACcodes3,120,168,DCTAB,ACTAB,16,3);
pic_jpeg3=anti_JPEG(DCcodes3,ACcodes3,H3,W3,DCTAB,ACTAB,QTAB);
disp('隐藏方法3 PSNR：');
disp(PSNR(pic,pic_jpeg3));
disp('压缩率');
disp(8*H3*W3/(length(DCcodes3)+length(ACcodes3)));