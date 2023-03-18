function x=solvess(A,B,u,x0,t)
    n=length(x0);
    N=length(t);
    I=eye(n,n);
    x=zeros(n,N);
    for k=1:N
        x(:,k)=expm(A*t(k))*x0 + inv(A)*(expm(A*t(k)) - I)*B*u;
    end
end