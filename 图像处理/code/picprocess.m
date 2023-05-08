function [B] =picprocess(A,QTAB)
[m,n]=size(A);
x=ceil(m/8);%纵向分块数
y=ceil(n/8);%横向分块数
if(mod(m,8)~=0||mod(n,8)~=0)
    A(8*x,8*y)=0;%用零扩充图像
end
B=cell(1,x*y);%初始化结果元胞数组
C=mat2cell(double(A)-128,8*ones(1,x),8*ones(1,y));%预处理和分块
C=cellfun(@dct2,C,UniformOutput=false);%分块进行二维DCT变换
C=cellfun(@(C)QT(C,QTAB),C,UniformOutput=false);%量化
C=cellfun(@zigzag_1,C,UniformOutput=false);%Zig-Zag扫描
k=1;
for ii=1:x
    for jj=1:y
        B{1,k}=C{ii,jj};%把15×21的元胞数组改写成1×315的元胞数组，方便转换成64*315的矩阵
        k=k+1;
    end
end
B=cell2mat(B);%元胞数组转换成矩阵
end