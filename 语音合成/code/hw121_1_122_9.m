FS=8000;
a1=1.3789;
a2=-0.9506;
num=[0 0 1];
den=[1 -a1 -a2];
omega=roots(den);
f=(abs(angle(omega(1))))*8000/(2*pi);%共振峰频率
tf(num,den,1)%传递函数
figure(1)
zplane(num,den);%画z平面零极点
figure(2)
freqz(num,den);%频率响应
figure(3)
yim=impz(num,den);%用impz求的单位样值响应
n=0:391;
stem(n,yim);
x=((n-0)==0);%单位样值信号
y=(filter(num,den,x))';%输入单位样值信号后的响应
figure(4)
stem(n,y);%画用filter求的单位样值响应
figure(5)
stem(n,y-yim);%两种单位样值响应的误差
%(9)
e_n=hw122_8();%调用hw122_8函数得到激励
s_n=filter(num,den,e_n);
%sound(s_n,FS);
%n=1:8000;
%figure(6)
%plot(n,s_n);



