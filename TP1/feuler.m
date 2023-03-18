function [t,x]=feuler(f,x0,h,t0,tf)
t=[t0:h:tf];
x=zeros(length(x0),length(t));
x(:,1)=x0;
for k=1:length(t)-1
x(:,k+1)=x(:,k)+h*f(x(:,k),t(k));
end
end