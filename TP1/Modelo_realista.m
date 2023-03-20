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

%% 4. Determinar el maximo paso de integracion que podria utilizarse 
% para simular este sistema con el metodo de Forward Euler.

% Formula Estabilidad: hmin < - 2 / lambda_min (mas rapido)

hmin = - 2 / min(lambda) % 2e-8

%% ***************************** EJ 8 ************************************



%% 3. Observar que ocurre al simular este modelo con el metodo de 
% Forward Euler o con el metodo de Heun

x0=[0;0];

tic;
[t,x]=feuler(@buck2,x0,1e-6,0,0.01);
tiempo_1 = toc;

figure(6);
plot(t,x(1,:),t,x(2,:));
title('Simulacion con foward Euler y paso de 1e-6');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=feuler(@buck2,x0,1e-7,0,0.01);
tiempo_2=toc;

figure(7);
plot(t,x(1,:),t,x(2,:))
title('Simulacion con foward Euler y paso de 1e-7');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=feuler(@buck2,x0,1e-8,0,0.01);
tiempo_3=toc;

figure(7);
plot(t,x(1,:),t,x(2,:))
title('Simulacion con foward Euler y paso de 1e-8');
legend('il vs t','uc vs t');
grid on;

%% 4. Observar que ocurre con RK23.
tic;
[t,x]=rk23(@buck2,x0,0,0.01,1e-3,1e-6);
tiempo_4=toc;

figure(8);
plot(t,x(1,:),t,x(2,:))
title('Simulacion con RK23');
legend('il vs t','uc vs t');
grid on;

%% 5. Simular el modelo utilizando Backward Euler con pasos de 
% integracion h = 2 10e-5 , h = 10e-5 y h = 10e-6

x0=[0;0];

tic;
[t,x]=beuler(@buck2,x0,2e-5,0,0.01);
tiempo_5 = toc;

figure(9);
plot(t,x(1,:),t,x(2,:));
title('Simulacion con backward Euler y paso de 2e-5');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=beuler(@buck2,x0,1e-5,0,0.01);
tiempo_6 = toc;

figure(10);
plot(t,x(1,:),t,x(2,:));
title('Simulacion con backward Euler y paso de 1e-5');
legend('il vs t','uc vs t');
grid on;


tic;
[t,x]=beuler(@buck2,x0,1e-6,0,0.01);
tiempo_7=toc;

figure(11);
plot(t,x(1,:),t,x(2,:))
title('Simulacion con backward Euler y paso de 1e-6');
legend('il vs t','uc vs t');
grid on;


