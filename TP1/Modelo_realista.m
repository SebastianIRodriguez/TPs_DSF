%% Ej 7

Roff = 1e5;
Ron = 1e-5;
U = 12; L = 10e-4; C = 10e-4; R = 10;

%x1=il, x2= uc
%% 2. Escribir las Ecuaciones de Estado obtenidas en forma matricial para el caso s = 0 (llave abierta,
% RS = Roff) considerando adem�as negativa la corriente del diodo (RD = Roff)

Rs = Roff;
Rd = Roff;
A=[-Rs/L -1*Rs/(R*L);-1/C -1/(R*C)];
B=[-1;0];

%% 3. Calcular la posici�n de los autovalores de la matriz A suponiendo que los nuevos par�metros son
% Ron = 10?5? y Roff = 105?.

lambda=eig(A);

%% 4. Determinar el m�aximo paso de integracion que podria utilizarse 
% para simular este sistema con el metodo de Forward Euler.

% Formula Estabilidad: hmin < - 2 / lambda_min (mas r�pido)

hmin = - 2 / min(lambda) % 2e-8