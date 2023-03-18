model buck2

parameter Real T=1e-4,dc=0.5,L=1e-4,C=1e-4,R=10,U=12;

parameter Real Ron=1e-5,Roff=1e5;

Real iL,uL,uC,iC,uR,iR,uD,iD,uS,iS,uF,iF,s;

equation
  s=if rem(time,T)<dc*T then 1 else 0;
  L* der(iL)-uL=0;
  C* der(uC)-iC=0;
  R* iR-uR=0;
  uD=if iD>0 then Ron*iD else Roff*iD;
  uS=if s>0.5 then Ron*iS else Roff*iS;
  uF-U=0;
  iS+iD-iL=0;
  uD+uL+uC=0;
  iS-iF=0;
  uF-uS+uD=0;
  iL-iC-iR=0;
  uC-uR=0;
end buck2;
