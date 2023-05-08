function [B] =DCcode(A,DCTAB)
A_temp=[2*A(1,1),A(:,1:size(A,2)-1)];
A=A_temp-A;%差分编码
B='';
for k=1:size(A,2)
    if(A(1,k)==0)
        x=1;
    else
        x=floor(log2(abs(A(1,k))))+2;
    end
    y=DCTAB(x,1);%取码长
    for ii=2:y+1
        B=strcat(B,int2str(DCTAB(x,ii)));%按码长拼接对应的Huffman码
    end
    
    magnitudeA=dec2bin(abs(A(1,k)));%得到二进制的magnitude
    if(A(1,k)>=0)
        B=strcat(B,magnitudeA);%大于0直接拼接原码
    else
        temp1=strrep(magnitudeA,'0','a');%利用strrep函数实现01互换，也即求1-补码
        temp2=strrep(temp1,'1','0');
        B=strcat(B,strrep(temp2,'a','1'));%拼接得到的1-补码
    end
end