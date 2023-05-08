function [v] =fetch_v(path,num,L)
v=zeros(2^(3*L),1,num);
w=zeros(2^(3*L),1);
for i=1:num
    pic=imread(strcat(path,num2str(i),'.bmp'));%读取训练图片
    pic=bitshift(double(pic),L-8);
    pic=reshape(pic,1,size(pic,1)*size(pic,2),3);%重整成行向量，方便按下标遍历
    for j=1:length(pic)
        index=bitshift(pic(1,j,1),2*L)+bitshift(pic(1,j,2),L)+pic(1,j,3)+1;%计数颜色出现次数
        v(index,1,i)=v(index,1,i)+1;
    end
    v(:,1,i)=v(:,1,i)/sum(v(:,1,i));%把次数变成频率
end
for i=1:num
    w=w+v(:,1,i);
end
v=w/num;
end
