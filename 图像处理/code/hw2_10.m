load('jpegcodes.mat')
disp('图像压缩比是');
p=H*W*8/(size(AC_code,2)+size(DC_code,2));
disp(p);
