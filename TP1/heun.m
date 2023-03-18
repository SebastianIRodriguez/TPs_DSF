function [t,x]=heun(f,x0,h,t0,tf)
    t=[t0:h:tf];
    x=zeros(length(x0),length(t));
    x(:,1)=x0;
    for k=1:length(t)-1
        k1=f(x(:,k),t(k));
        k2=f(x(:,k)+h*k1,t(k+1));
        x(:,k+1)=x(:,k)+h/2*(k1+k2);
    end
end

