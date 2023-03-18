model buck_converter_simple_conmutado

parameter Real T=1e-4,dc=0.5,L=1e-4,C=1e-4,R=10,U=12;

Real iL,uL,uC,iC,uR,iR,uSD,iSD,s;

equation
  s=if rem(time,T) < dc*T then 1 else 0;
  L*der(iL)-uL=0;
  C*der(uC)-iC=0;
  R*iR-uR=0;
  uSD-U*s=0;
  iSD-iL=0;
  uSD-uL-uC=0;
  iL-iC-iR=0;
  uC-uR=0;
end buck_converter_simple_conmutado;
