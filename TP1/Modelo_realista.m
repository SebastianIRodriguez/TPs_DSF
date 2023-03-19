%% Ej 7

Roff = 1e5;
Ron = 1e-5;
U = 12; L = 10e-4; C = 10e-4; R = 10;

%x1=il, x2= uc
%% 2. Escribir las Ecuaciones de Estado obtenidas en forma matricial para el caso s = 0 (llave abierta,
% RS = Roff) considerando adem´as negativa la corriente del diodo (RD = Roff)

Rs = Roff;
Rd = Roff;
A=[-Rs/L -1*Rs/(R*L);-1/C -1/(R*C)];
B=[-1;0];

%% 3. Calcular la posición de los autovalores de la matriz A suponiendo que los nuevos parámetros son
% Ron = 10?5? y Roff = 105?.

lambda=eig(A);

%% 5. Simular el modelo utilizando Backward Euler con pasos de 
% integración h = 2 10?5 , h = 10?5 y h = 10?6
x0=[0;0];

tic;
[t,x]=feuler(@buck2,x0,1e-5,0,0.01);
tiempo_1 = toc;

figure(5);
plot(t,x(1,:),t,x(2,:));
title('Simulación con backward Euler y paso de 1e-5');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=feuler(@buck2,x0,1e-6,0,0.01);
tiempo_2 = toc;

figure(6);
plot(t,x(1,:),t,x(2,:));
title('Simulación con backward Euler y paso de 1e-6');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=feuler(@buck2,x0,1e-7,0,0.01);
tiempo_3=toc;

figure(7);
plot(t,x(1,:),t,x(2,:))
title('Simulación con backward Euler y paso de 1e-7');
legend('il vs t','uc vs t');
grid on;

%%

x0=[0;0];

tic;
[t,x]=beuler(@buck2,x0,1e-5,0,0.01);
tiempo_1 = toc;

figure(5);
plot(t,x(1,:),t,x(2,:));
title('Simulación con backward Euler y paso de 1e-5');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=beuler(@buck2,x0,1e-6,0,0.01);
tiempo_2 = toc;

figure(6);
plot(t,x(1,:),t,x(2,:));
title('Simulación con backward Euler y paso de 1e-6');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=beuler(@buck2,x0,1e-7,0,0.01);
tiempo_3=toc;

figure(7);
plot(t,x(1,:),t,x(2,:))
title('Simulación con backward Euler y paso de 1e-7');
legend('il vs t','uc vs t');
grid on;

%% 4. Determinar el m´aximo paso de integracion que podria utilizarse 
% para simular este sistema con el metodo de Forward Euler.

% Formula Estabilidad: hmin < - 2 / lambda_min (mas rápido)

hmin = - 2 / min(lambda) % 2e-8
