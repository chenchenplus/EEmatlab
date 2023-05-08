function [B] =DCdecode(DCcodes,DCTAB,n)
DCtree=buildtree(DCTAB,0);
B=zeros(1,n);%初始化结果矩阵
k=1;%记录码流位置
for i=1:n
    index=1;%每次循环从根节点开始
    while(1)
        if(DCtree(index).category~=-1)%说明已经找到了一段Huffman编码对应的Category
            break
        end
        if(DCcodes(k)=='0')
            index=DCtree(index).left;
        elseif(DCcodes(k)=='1')
            index=DCtree(index).right;
        end
        k=k+1;
    end
    delta_k=DCtree(index).category; %读取编码位置移动category位
    if(delta_k==0) %category是0
        B(i)=0;
        delta_k=1;
    elseif(DCcodes(k)=='1') %说明不是负数
        B(i)=bin2dec(DCcodes(1,k:k+delta_k-1));
    else
        temp1=strrep(DCcodes(1,k:k+delta_k-1),'0','a');
        temp2=strrep(temp1,'1','0');
        temp3=strrep(temp2,'a','1');
        B(i)=-bin2dec(temp3);
    end
    k=k+delta_k;
    
end
B(1,2:n)=-B(1,2:n);
for i=2:n
    B(1,i)=B(1,i)+B(1,i-1);%逆差分编码
end
end