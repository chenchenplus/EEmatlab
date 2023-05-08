function tree=buildtree(encode_table,type)
[m,~]=size(encode_table);
if(type==0)%构造DC解码的tree
    tree(1)= struct('left',0,'right',0,'category',-1);%根节点
    treesize=1;%树的结点数
    for i=1:m
        l=encode_table(i,1);%编码长度
        index=1;%每次从根节点开始遍历
        code=encode_table(i,2:l+1);
        for j=1:length(code)
            if(code(j)==0)
                if(tree(index).left==0)%不存在左子树
                    treesize=treesize+1;
                    tree(treesize)=struct('left',0,'right',0,'category',-1);%构建左子树
                    tree(index).left=treesize;%连接左子树
                    index=treesize;
                else
                    index=tree(index).left;%更新index
                end
            elseif(code(j)==1)
                if(tree(index).right==0)%不存在右子树
                    treesize=treesize+1;
                    tree(treesize)=struct('left',0,'right',0,'category',-1);%构建右子树
                    tree(index).right=treesize;%连接右子树
                    index=treesize;
                else
                    index=tree(index).right;%更新index
                end
            end
            
        end
        tree(index).category=i-1;%将Huffman码对应的十进制category存入节点数据域    
    end
elseif(type==1)%构造AC解码的tree
    tree(1)= struct('left',0,'right',0,'run',-1,'size',-1);%根节点
    treesize=1;%树的结点数
    for i=1:m
        l=encode_table(i,3);%编码长度
        index=1;%每次从根节点开始遍历
        code=encode_table(i,4:l+3);
        for j=1:length(code)
            if(code(j)==0)
                if(tree(index).left==0)%不存在左子树
                    treesize=treesize+1;
                    tree(treesize)=struct('left',0,'right',0,'run',-1,'size',-1);%构建左子树
                    tree(index).left=treesize;%连接左子树
                    index=treesize;
                else
                    index=tree(index).left;%更新index
                end
            elseif(code(j)==1)
                if(tree(index).right==0)%不存在右子树
                    treesize=treesize+1;
                    tree(treesize)=struct('left',0,'right',0,'run',-1,'size',-1);%构建右子树
                    tree(index).right=treesize;%连接右子树
                    index=treesize;
                else
                    index=tree(index).right;%更新index
                end
            end
            
        end
        if(i<m-1) %针对在最后两行加入EOB和ZRL对应编码，节点数剧域填充也要分段
            tree(index).run=floor((i-1)/10);%将Huffman码对应的十进制Run、Size存入节点数据域 
            tree(index).size=i-10*floor((i-1)/10);
        else
            tree(index).run=16*(m-i);%对应ZRL和EOB的run
            tree(index).size=0;
        end
    end
    
end

end