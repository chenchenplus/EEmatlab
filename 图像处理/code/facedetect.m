function [isface] =facedetect(pic,L,d_max,l_block)
[v]=fetch_v('Faces/',33,L);%得到标准v
[H,W,~]=size(pic);
x=ceil(H/l_block);%纵向正方形块数
size_x=l_block*ones(1,x);%行方向分割方法
y=ceil(W/l_block);%横向正方形块数
size_y=l_block*ones(1,y);%列方向分割方法
if(20*x>H)
    size_x=[l_block*ones(1,x-1),H+l_block-l_block*x];
end
if(20*y>W)
    size_y=[l_block*ones(1,y-1),W+l_block-l_block*y];
end
%寻找可以判做人脸的图块
isface=zeros(x,y);%根据阈值判断图像块是不是满足标准，满足则对应元素置1，否则置0
C=mat2cell(double(pic),size_x,size_y,3);%分块
for ii=1:x
    for jj=1:y
        d=distance_uv(C{ii,jj},v,L);%得到图像块特征和标准的距离
        if(d<d_max)%d_max作为阈值
            isface(ii,jj)=1;
        end
        
    end
end
imshow(pic);
hold on
for i=1:x
    for j=1:y           
        if(isface(i,j)==1)
            if(i==x)
                h=size_x(end);
            else
                h=l_block;
            end
            if(j==y)
                w=size_y(end);
            else
                w=l_block;
            end
            rectangle('Position',[l_block*(j-1)+1,l_block*(i-1)+1,h,w],'LineWidth',1,'EdgeColor','r');
        end
    end
end
end