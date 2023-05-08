load('hall.mat');
data='matlab';
bindata=zeros(1,8*size(data,2)+8);% 字符对应的ascⅡ码用8bit即可存储
                                  % 多出的8bit用来存停止位，设置为8个0
                                  
for i=1:length(data)
    bindata_i=dec2bin(data(1,i));
    for j=8:-1:9-length(bindata_i)
        bindata(1,8*i-8+j)=bindata_i(end+j-8)-'0';
    end
end
%信息隐藏
pic=hall_gray;
B=reshape(pic,1,size(pic,1)*size(pic,2));%重整成1行的矩阵，方便信息隐藏
k=1;%标示信息已经存储到第几位
while(1)
    B(1,k)=2*floor(B(1,k)/2)+bindata(1,k);%由于是最低位存信息，只要把最低位置0再加上信息位即可
    k=k+1;
    if(k==8*size(data,2)+9)
        break
    end
end
picwithdata=reshape(B,size(pic,1),size(pic,2));
%imshow(picwithdata)
%信息提取
C=reshape(picwithdata,1,size(picwithdata,1)*size(picwithdata,2));%矩阵变形方便操作
data_recover='';
i=0;
while(1)
    data_i='';
    for j=1:8
        data_i=strcat(data_i,mod(C(1,i+j),2)+'0');%用判断是不是偶数的方法得到信息位
    end
    i=i+8;
    if(data_i=='0'+zeros(1,8))%每8位判断有没有碰到停止符
        break
    end
    bin2dec(data_i);
    data_recover=strcat(data_recover,char(bin2dec(data_i)));
end
disp('读取信息为:');
disp(data_recover);
load('JpegCoeff.mat');
[DCcodes,ACcodes,H,W] =JPEG(picwithdata,DCTAB,ACTAB,QTAB);
pic_jpeg=anti_JPEG(DCcodes,ACcodes,H,W,DCTAB,ACTAB,QTAB);
imshow(pic_jpeg)
%信息提取
C=reshape(pic_jpeg,1,size(pic_jpeg,1)*size(pic_jpeg,2));%矩阵变形方便操作
data_recover='';
i=0;
while(1)
    data_i='';
    for j=1:8
        data_i=strcat(data_i,mod(C(1,i+j),2)+'0');%用判断是不是偶数的方法得到信息位
    end
    i=i+8;
    if(data_i=='0'+zeros(1,8))%每8位判断有没有碰到停止符
        break
    end
    bin2dec(data_i);
    data_recover=strcat(data_recover,char(bin2dec(data_i)));
end
disp('读取信息为:');
disp(data_recover);

        
