function [B] =ACcode(A,ACTAB)
EOB='1010';
ZRL='11111111001';
B='';
Run=0;
for i=1:size(A,2)
    A_i=A(1:size(A,1),i);
    index=find(A_i~=0);
    if(size(index,1)==0)%AC系数全是0
        B=strcat(B,EOB);
        continue
    end
    A_i=A_i(1:index(end),1);%去掉AC系数末尾的0
    for j=1:size(A_i,1)
    if(A_i(j,1)==0)
        Run=Run+1;
        if(Run==16)
            B=strcat(B,ZRL);
            Run=0;
        end
    else
        Size=floor(log2(abs(A_i(j,1))))+1;
        L=ACTAB(Run*10+Size,3);%取码长
        for ii=1:L
        B=strcat(B,int2str(ACTAB(Run*10+Size,ii+3)));%按码长拼接对应的Huffman码
        end
        Amplitude_j=dec2bin(abs(A_i(j,1)));%得到二进制的amplitude
        if(A_i(j,1)>=0)
            B=strcat(B,Amplitude_j);%大于0直接拼接原码
        else
            temp1=strrep(Amplitude_j,'0','a');%利用strrep函数实现01互换，也即求1-补码
            temp2=strrep(temp1,'1','0');
            B=strcat(B,strrep(temp2,'a','1'));%拼接得到的1-补码
         end


        Run=0;
    end
   
    end
    B=strcat(B,EOB);
    
end