function [B] =pic_antiprocess(A,QTAB,m,n)
B=cell(floor(m/8),floor(n/8));%初始化结果元胞数组
C=mat2cell(double(A),size(A,1),ones(1,size(A,2)));%按块把矩阵分割
C=cellfun(@anti_zigzag,C,UniformOutput=false);%分块进行逆Zig-Zag变换
C=cellfun(@(C)anti_QT(C,QTAB),C,UniformOutput=false);%反量化
C=cellfun(@idct2,C,UniformOutput=false);%逆DCT
k=1;
for ii=1:floor(m/8)
    for jj=1:floor(n/8)
        B{ii,jj}=C{1,k};%把1×315的元胞数组改写成15×21的元胞数组
        k=k+1;
    end
end
B=uint8(cell2mat(B)+128);
end