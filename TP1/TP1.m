%% Ej 1
% Luego del ordenamiento resulta:

ir=uc/R;
ic=il-ir;
ul=U * s-uc;
dil=ul/L;
duc=ic/C;

% Dejando explícito:
dil=(U * s-uc)/L;
duc=(il-uc/R)/C;

%% Ej 2
% 1. Escribir las Ecuaciones de Estado obtenidas en el item 3 del 
% Problema 1 en forma matricial
U=12;
L=10e-4;
C=10e-4;
R=10;

A=[0 -1/L;1/C -1/(R*C)];
B=[1/L;0];

x0=[0;0];
t=[0:1e-5:0.01];
xa=solvess(A,B,U,x0,t);

figure(1);
grid on;
hold on;
% Top plot
%subplot(2,1,1);
title('Solucion analitica');
plot(t,xa(1,:),t,xa(2,:));
legend('il vs t','uc vs t');


%% Ej 3 Foward Euler

[t,x]=feuler(@buck_converter,x0,1e-5,0,0.01);
figure(2);
grid on;
hold on;
% Top plot
%subplot(2,1,1);
title('Solucion analitica');
plot(t,x(1,:),t,x(2,:));
legend('il vs t','uc vs t');

%% Ej 4 Metodo de Heun
% Repetir el Problema 3 utilizando ahora el metodo de Heun, que puede 
% implementarse mediante el Codigo 4. Utilizar en este caso pasos de
% integracion h = 10^?4, h = 2*10^?5 y h = 10^?5.
% Analizar la estabilidad y como cambia el error tras un paso al variar h.

[t1, x1] = heun(@buck_converter,x0,1*(10^-4),0,0.1);

[t2, x2] = heun(@buck_converter,x0,2*(10^-5),0,0.1);

[t3, x3] = heun(@buck_converter,x0,1*(10^-5),0,0.1);

plot(t1,x1,t2,x2,t3,x3);

