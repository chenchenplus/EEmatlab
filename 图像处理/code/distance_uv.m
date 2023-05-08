function [d] =distance_uv(pic,v,L)
u=zeros(2^(3*L),1);
pic=bitshift(pic,L-8);
pic=reshape(pic,1,size(pic,1)*size(pic,2),3);%重整成行向量，方便按下标遍历
for i=1:length(pic)
    index=bitshift(pic(1,i,1),2*L)+bitshift(pic(1,i,2),L)+pic(1,i,3)+1;%计数颜色出现次数
    u(index,1)=u(index,1)+1;
end
u(:,1)=u(:,1)/sum(u(:,1));%把次数变成频率
d=1-sqrt(u)'*sqrt(v);
end