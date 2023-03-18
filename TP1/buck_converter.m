function dx=buck_converter(x,t)
%parametros
L=10e-4;
C=10e-4;
R=10;

% Entrada
U=12;

%x(1) = il
%x(2) = uc

der_x1=(U-x(2))/L;
der_x2=(x(1)-x(2)/R)/C;
dx=[der_x1; der_x2]; %vector de derivadas
end