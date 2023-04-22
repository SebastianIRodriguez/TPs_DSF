function [t,xa]=solan(h,tfinal)
U=12;
L=1e-4;
C=1e-4;
R=10;
A=[0 -1/L;1/C -1/(R*C)];
B=[1/L;0];

x0=[0;0];
t=[0:h:tfinal];
xa=solvess(A,B,U,x0,t);
end