function e_n=hw122_8()
FS=8000;
e_n=zeros(8000,1);
n_loop=1;
while n_loop<=8000
   m=round(n_loop/80);
   PT=80 + 5*mod(m, 50);
   e_n(n_loop,1)=1;
   n_loop=n_loop+PT;

end
%sound(e_n,FS)
%n=1:8000;
%plot(n,e_n);
%set(gca,'Ylim',[0,1.3]);
end
