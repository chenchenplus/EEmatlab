function [DC_code,AC_code,H,W] =JPEGfor3_2(pic,DCTAB,ACTAB,QTAB,type)
[H,W]=size(pic);
pic_DCT=picprocess(pic,QTAB);%实现图像分块，二维DCT，量化和Zig-Zag扫描
bindata=[1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0];%只储存16位信息,为了编写方便数据选择16位数组
if(type==1)%替换掉每个量化后的DCT系数的最低位
    %信息隐藏
    pic=pic_DCT;
    B=reshape(pic,1,size(pic,1)*size(pic,2));%重整成1行的矩阵，方便信息隐藏
    k=1;%标示信息已经存储到第几位
    B=2*floor(B/2);%为了改变所有的DCT系数，把DCT矩阵所有元素变成偶数，相当于所有DCT系数的信息位都变成了0，
                   %规定停止位是8个0，由于除了16个储存的信息外都是0，因此不用另设停止位
    while(1)
        B(1,k)=B(1,k)+bindata(1,k);%由于是最低位存信息，只要把最低位置0再加上信息位即可
        k=k+1;
        if(k==17)
            break
        end
    end
    pic_DCT=reshape(B,size(pic,1),size(pic,2));
elseif(type==2)%替换若干量化后的DCT系数的最低位
    %信息隐藏
    pic=pic_DCT;
    bindata2=[bindata,zeros(1,8)];%加上停止位
    B=reshape(pic,1,size(pic,1)*size(pic,2));%重整成1行的矩阵，方便信息隐藏
    k=1;%标示信息已经存储到第几位
    while(1)
        B(1,k)=2*floor(B(1,k)/2)+bindata2(1,k);%由于是最低位存信息，只要把最低位置0再加上信息位即可
        k=k+1;
        if(k==17+8)
            break
        end
    end
    pic_DCT=reshape(B,size(pic,1),size(pic,2));
elseif(type==3)%用1，-1表示信息
    %信息隐藏
    B=pic_DCT;
    bindata3=2*bindata-1;%把要储存的数据变成-1，1形式
    for i=1:size(bindata3,2)
        index=find(B(:,i)~=0);%找到第i块最后一个非零值
        if(size(index,1)==0)%这个图像块Zig-Zag结果全是0
            B(1,i)=bindata3(i);%置直流系数为信息位
        else
            B(index(end),i)=bindata3(i);
        end
    end
    pic_DCT=B;    
end
DC_code=DCcode(pic_DCT(1,:),DCTAB);%生成DC码流
AC_code=ACcode(pic_DCT(2:size(pic_DCT,1),:),ACTAB);%生成AC码流
end