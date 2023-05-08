function [data_recover] =DataDecodefor3_2(DC_code,AC_code,H,W,DCTAB,ACTAB,datasize,type)
B1=DCdecode(DC_code,DCTAB,H*W/64);
AC_encodetable=[ACTAB;16,0,11,1,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0;
                0,0,4,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0];%用ZRL和EOB编码填充
B2=ACdecode(AC_code,AC_encodetable,8*8-1,H*W/64);
pic_DCT=[B1;B2];%从DC、AC码流恢复量化后的系数矩阵
if(type==1||type==2)
    %信息提取
    C=reshape(pic_DCT,1,size(pic_DCT,1)*size(pic_DCT,2));%矩阵变形方便操作
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
elseif(type==3)
    data_recover='';
    i=0;
    while(1)
        data_i='';
        for j=1:8
            index=find(pic_DCT(:,i+j)~=0);
            data_i=strcat(data_i,(pic_DCT(index(end),i+j)+1)/2+'0');%直接取Zig-Zag扫描后的最靠后非零位为信息位
        end
        i=i+8;
        if(i==datasize+8)%判断读取数据停止
            break
        end
        bin2dec(data_i);
        data_recover=strcat(data_recover,char(bin2dec(data_i)));
    end
    
end
end