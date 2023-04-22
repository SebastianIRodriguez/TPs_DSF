function dx=buck1(x,t)
    T=1e-4; dc=0.5; %periodo y ciclo de trabajo
    r=rem(t,T); %resto de la division entera entre el tiempo y el periodo
    
    if r < dc * T
        s=1;
    else
        s=0;
    end

    %parametros
    L=1e-4;
    C=1e-4;
    R=10;

    % Entrada
    U=12;

    %x(1) = il
    %x(2) = uc

    der_x1=(U*s-x(2))/L;
    der_x2=(x(1)-x(2)/R)/C;
    dx=[der_x1; der_x2]; %vector de derivadas
end