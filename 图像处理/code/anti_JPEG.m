function [pic_jpeg] =anti_JPEG(DC_code,AC_code,H,W,DCTAB,ACTAB,QTAB)
B1=DCdecode(DC_code,DCTAB,H*W/64);
AC_encodetable=[ACTAB;16,0,11,1,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0;
                0,0,4,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0];%用ZRL和EOB编码填充
B2=ACdecode(AC_code,AC_encodetable,8*8-1,H*W/64);
B=[B1;B2];%拼接DC和AC部分
pic_jpeg=pic_antiprocess(B,QTAB,H,W);
end