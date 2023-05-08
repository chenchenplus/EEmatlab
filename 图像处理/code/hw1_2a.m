load('hall.mat');
[h,w,~]=size(hall_color);
r=min(h/2,w/2);
imshow(hall_color);
hold on
theta = 0:pi/60:2*pi;
x = w/2+r*cos(theta);
y = (h+1)/2+r*sin(theta);%直接写h/2画出来的圆有缺口
plot(x,y,'r');%画图
set(gca,'Position',[0 0 1 1]);
saveas(gca,"1_2a.png");
