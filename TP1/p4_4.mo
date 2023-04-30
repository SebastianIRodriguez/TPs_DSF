model p4_4

parameter Real m=1, k = 10, b = 10, g = 9.8;
parameter Real d1 = 1, d2 = 2, yp = 1;
parameter Real Lor = 1, Loa = 1, Lm = 1;

Real ym(start=1),vm,y1,y2,yrelr,yrela(start=0),Fa,Fr,Fm,Fg,F1,F2;

equation

der(ym) - vm = 0;
m*der(vm)-Fm = 0;

k*yrelr - Fr = 0;

b*der(yrela) - Fa = 0;

(d1/d2) * y2 + y1 - yp*(d1+d2)/d2 = 0;
F1 + (d2/d1)*F2 = 0;

Fg - m*g = 0;

yrelr + Lor - y2 = 0;
yrela + Loa - y1 = 0;
y2 + Lm - ym = 0;
Fm + Fr - Fg - F2 = 0;
Fa + F1 = 0;

end p4_4;
