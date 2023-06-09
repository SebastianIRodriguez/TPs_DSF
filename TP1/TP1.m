%% Ej 1
% Luego del ordenamiento resulta:

ir=uc/R;
ic=il-ir;
ul=U * s-uc;
dil=ul/L;
duc=ic/C;

% Dejando expl�cito:
dil=(U * s-uc)/L;
duc=(il-uc/R)/C;

%% Ej 2
% 1. Escribir las Ecuaciones de Estado obtenidas en el item 3 del 
% Problema 1 en forma matricial
U=12;
L=1e-4;
C=1e-4;
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

%% Autovalores de A
lambda = eig(A)
% p1,2 = -50 +- 998.7492

%% Ej 3 Forward Euler

[t,xa]=solan(1e-5,0.01);
[t,x]=feuler(@buck_converter,x0,1e-5,0,0.01);
figure(2);
grid on;
hold on;
title('Simulacion por forward Euler con paso de 1e-5');
plot(t,x(1,:),t,x(2,:));
legend('il vs t','uc vs t');
error_1=norm(x(:,2)-xa(:,2));


%% con paso 1e-6
[t,xa]=solan(1e-6,0.01);
[t,x]=feuler(@buck_converter,x0,1e-6,0,0.01);
figure(3);
grid on;
hold on;
title('Simulacion por forward Euler con paso de 1e-6');
plot(t,x(1,:),t,x(2,:));
legend('il vs t','uc vs t');
error_2=norm(x(:,2)-xa(:,2));

%% Ej 4 Metodo de Heun
% Repetir el Problema 3 utilizando ahora el metodo de Heun, que puede 
% implementarse mediante el Codigo 4. Utilizar en este caso pasos de
% integracion h = 10^?4, h = 2*10^?5 y h = 10^?5.
% Analizar la estabilidad y como cambia el error tras un paso al variar h.

[t1, x1] = heun(@buck_converter,x0,1e-4,0,0.01); %% 8 se va

[t2, x2] = heun(@buck_converter,x0,2e-5,0,0.01);

[t3, x3] = heun(@buck_converter,x0,1e-5,0,0.01);

figure(4);
plot(t1,x1,'r',t2,x2,'g',t3,x3,'b');
title('Metodo de Heun');
grid on;

%% Errores
[t,xa]=solan(1e-4,0.01);
e1 = norm(x1(:,2)-xa(:,2)); 

[t,xa]=solan(2e-5,0.01);
e2 = norm(x2(:,2)-xa(:,2)); 

[t,xa]=solan(1e-5,0.01);
e3 = norm(x3(:,2)-xa(:,2)); 

%% Ej 5 Metodo de Runge Kutta con Control de Paso
% Simular el modelo utilizando ahora un metodo de RK23 de paso variable,
% que puede implementarse mediante el Codigo 5.

%% 1. Utilizar tolerancias relativa y absoluta rtol = 10?3, atol = 10?6.
% Graficar los resultados y calcular numero de pasos del metodo (length(t)).
% Graficar tambien el tamano del paso h (plot(diff(t))).
[t1, x1] = rk23(@buck_converter, x0, 0, 0.01, 1e-3, 1e-6);

n_pasos1 = length(t1);

figure(5);
subplot(2,1,1), plot(t1,x1);
title('Metodo de Runge-Kutta - rtol = 1e-3 - atol = 1e-6');
subplot(2,1,2), plot(diff(t1));
grid on;

%% 2. Repetir el punto anterior para tolerancias relativa y absoluta
% rtol = atol = 1e-6.

[t2, x2] = rk23(@buck_converter, x0, 0, 0.01, 1e-6, 1e-6);

n_pasos2 = length(t2)

figure(6);
subplot(2,1,1), plot(t2,x2);
title('Metodo de Runge-Kutta - rtol = atol = 1e-6');
subplot(2,1,2), plot(diff(t2));
grid on;

%% Comparacion

figure(6);
subplot(2,1,1),
plot(t1, x1, 'r', t2, x2, 'b'),
title('Metodo de Runge-Kutta - Comparacion'),
legend('rtol = 10^-3, atol = 10^-6', '', 'rtol = atol = 10^-6', '');

subplot(2,1,2),
plot(1:1:n_pasos1-1, diff(t1), 'r', 1:1:n_pasos2-1, diff(t2), 'b'), 
legend('rtol = 10^-3, atol = 10^-6', 'rtol = atol = 10^-6');

% Las graficas son muy similares a pesar de haber reducido la tolerancia
% relativa.
% En el primer caso, los pasos son mucho mayores y aumentan mucho mas
% rapido.
% En ambos casos, a medida que la oscilacion se reduce, el paso aumenta.


%% Ej 6 Simulacion del Modelo Conmutado
% Consideraremos ahora que la llave conmuta con un periodo de T = 1e-4 seg
% y que el ciclo de trabajo es del 50 %.
% Para simular el modelo bajo esta suposicion, se pide lo siguiente:

%% 1. 
% Modificar la funcion desarrollada en el item 2 del Problema 3 de manera
% que ahora la senal s(t) cambia de acuerdo a las conmutaciones de la llave.
% Ayuda: Para generar la senal dentro de la funcion que calcula la
% derivada, puede usar el siguiente fragmento de codigo: ...

%% 2.
% Simular este nuevo sistema usando el metodo de Heun con los siguientes
% pasos de integracion: h = 2e-5, h = 1e-5 y h = 1e-6.
% Explicar lo que observa.

[t1, x1] = heun(@buck1,x0,2e-5,0,0.004);

[t2, x2] = heun(@buck1,x0,1e-5,0,0.004);

[t3, x3] = heun(@buck1,x0,1e-6,0,0.004);

figure(7);
plot(t1,x1,'r',t2,x2,'g',t3,x3,'b');
title('Comparacion Heun - Modelo Conmutado')
legend('h = 2e-5', '', 'h = 1e-5', '', 'h = 1e-6')

%% 3.
% Simular utilizando RK23 con tolerancias relativa y absoluta rtol = 1e-3 
% y atol = 1e-6.
% Graficar los resultados y la evolucion del paso de integracion.

[t, x] = rk23(@buck1, x0, 0, 0.01, 1e-3, 1e-6);

figure(8);
subplot(2,1,1), plot(t,x), legend('il', 'uc');
title('Runge-Kutta - Modelo Conmutado')
subplot(2,1,2), plot(diff(t));

%% 4.
% Comparar los resultados con lo que se obtiene a partir del modelo de
% Modelica del Codigo 7 simulando con OpenModelica.

%% 5.
% Observar la corriente iSD(t), o su alias iL(t), y analizar que ocurre 
% con la corriente por el diodo mientras la llave se encuentra abierta
% para tiempos entre t = 3e-4 y t = 6e-4.
% �Hay algun problema con las hipotesis simplificatorias que se hicieron
% para llegar a la Ec.(1)?

% Se observa que en ese periodo de tiempo, la corriente iSD es negativa, lo
% lo cual no es coherente debido a la presencia del diodo, que fuerza a que
% la corriente pueda adoptar un unico sentido de circulacion.
% Este comportamiento no se modela en la Ec. (1)



