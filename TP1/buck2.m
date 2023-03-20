function dx=buck2(x,t)
L=1e-4;C=1e-4;R=10;U=12;Ron=1e-5;Roff=1e5; %parametros
T=1e-4;dc=0.5;
iL=x(1);
uC=x(2);
r=rem(t,T); %resto de la division entera
if r<dc*T
s=1;
else
s=0;
end
if s>0.5
RS=Ron;
else
RS=Roff;
end
RD=Ron;
%suponemos inicialmente que el diodo conduce
iD=(iL-U/RS)/(1+RD/RS);
%ahora verificamos
if iD<=0
RD=Roff;
%recalculamos la corriente con el valor correcto de RD
iD=(iL-U/RS)/(1+RD/RS);
end

diL=(-((-U+RS*iL)/((RS/RD)+1))-uC)/L;
duC=iL/C-uC/(R*C);

dx=[diL;duC];

