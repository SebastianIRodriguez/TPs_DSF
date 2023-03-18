function [t,x]=beuler(f,x0,h,t0,tf)
t=[t0:h:tf];
x=zeros(length(x0),length(t));
x(:,1)=x0;
for k=1:length(t)-1
F=@(z)(z-x(:,k)-h*f(z,t(k))); %funcion que debe ser 0
x(:,k+1)=fsolve(F,x(:,k));
end
end