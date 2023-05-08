function [PSNR] =PSNR(pic,pic_jpeg)
[m,n]=size(pic);
A=double(pic)-double(pic_jpeg);
MSE = sum(sum(A.^2))/(m*n);
PSNR = 10*log10(255^2/MSE);
end