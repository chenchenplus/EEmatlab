function [B] =zigzag_2(A)
m=size(A,1);
n=size(A,2);
B=zeros(1,n*m);
x=1;y=1;            %从左上角开始扫描
k=1;                %扫描后得到1×mn大小的矩阵
while(k<=m*n)       %一共有mn个元素
B(k)=A(x,y);        %扫描元素
if(mod(x+y,2)==0)   %行列下标和是偶数
if(y==n)            %碰到右侧边界，则竖直向下扫描
x=x+1;
else
x=max(x-1,1);       %向右/右上扫描
y=y+1;
end
else
if(x==m)            %碰到下侧边界，则水平向右扫描
y=y+1;
else
x=x+1;              %向下/左下扫描
y=max(y-1,1);
end
end
k=k+1;              %更新k，准备下一次扫描
end
B=B';               %转换成列向量
end