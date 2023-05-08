function [B] =myidct2(A,m,n)
if(~exist('m','var'))
    m=size(A,1);%在没有传参的时候设置默认参数m
end
if(~exist('n','var'))
    n=size(A,2);%在没有传参的时候设置默认参数n
end
if(m>size(A,1)||n>size(A,2))
    A(m,n)=0;%用0自动扩充矩阵A到max(size(A,1),m)*max(size(A,2),n)
end
A=A(1:m,1:n);%截取A矩阵
D1=repmat((1:m-1)',1,m).*repmat(1:2:2*m-1,m-1,1);
D2=repmat((1:n-1)',1,n).*repmat(1:2:2*n-1,n-1,1);
D1=sqrt(2/m)*cos(D1*pi/(2*m));%得到第一行之外的算子矩阵
D2=sqrt(2/n)*cos(D2*pi/(2*n));
D1=[ones(1,m)/sqrt(m);D1];%加上第一行
D2=[ones(1,n)/sqrt(n);D2];
B=D1'*A*D2;%二维DCT逆变换
end

