a1=1.3789;
a2=-0.9506;
num=[0 0 1];
den=[1 -a1 -a2];
omega1=roots(den);
omega2(1)=omega1(1)*exp(150*pi/4000*1i);
omega2(2)=conj(omega2(1));
poly(omega2)