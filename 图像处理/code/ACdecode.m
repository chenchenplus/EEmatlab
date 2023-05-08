function [B] =ACdecode(ACcodes,ACTAB,m,n)
ACtree=buildtree(ACTAB,1);
B=zeros(m,n);%初始化结果矩阵,m在本题中是63，n是315，全零矩阵的好处是遇到应该填入0的位置可以直接改变j跳过
k=1;%记录码流位置
for i=1:n
    j=1;%记录每列矩阵的写入位置
    while(1)
    index=1;%每次循环从根节点开始
    while(1)
        if(ACtree(index).size~=-1)%说明已经找到了一段Huffman编码对应的Category
            break
        end
        if(ACcodes(k)=='0')
            index=ACtree(index).left;
        elseif(ACcodes(k)=='1')
            index=ACtree(index).right;
        end
        k=k+1;
    end
    delta_k=ACtree(index).size; %读取编码位置移动size位
    j=j+ACtree(index).run; %写入位置要下移run对应0的个数，EOB和ZRL的run也可以用这个计算
    if(ACtree(index).size==0)%EOB或ZRL
        if(ACtree(index).run==0)
            break %跳出条件1，遇到EOB
        
        end
   
    
    elseif(ACcodes(k)=='1')%说明不是负数
        B(j,i)=bin2dec(ACcodes(1,k:k+delta_k-1));
        j=j+1; %写入了这一个非零数，写入位置移动一个
    else
        temp1=strrep(ACcodes(1,k:k+delta_k-1),'0','a');
        temp2=strrep(temp1,'1','0');
        temp3=strrep(temp2,'a','1');
        B(j,i)=-bin2dec(temp3);
        j=j+1;
    end
    k=k+delta_k;
   
    end
    
end

end