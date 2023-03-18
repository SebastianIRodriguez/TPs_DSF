function [t,x]=rk23(f,x0,t0,tf,rtol,atol)
    t=zeros(1,10000);
    x=zeros(length(x0),length(t));
    
    t(1)=t0;
    x(:,1)=x0;
    
    h=tf/1e6; %paso inicial
    k=1;
    
    while t(k)<tf
        
        if t(k)+h>tf
            h=tf-t(k);
        end
        
        k1=f(x(:,k),t(k));
        k2=f(x(:,k)+h*k1,t(k)+h);
        k3=f(x(:,k)+h/4*k1+h/4*k2,t(k)+h/2);
        
        xa=x(:,k)+h/2*k1+h/2*k2;
        xb=x(:,k)+h/6*k1+h/6*k2+2/3*h*k3;
        
        if norm(xb-xa)<max(rtol*norm(xb),atol)
            x(:,k+1)=xb;
            t(k+1)=t(k)+h;
            k=k+1;
        end
        
        er=norm(xb-xa);
        e0=max(rtol*norm(xb),atol);
        h=0.8*h*(e0/er)^(1/3);
    end
    
    x=x(:,1:k);
    t=t(1:k);
end


