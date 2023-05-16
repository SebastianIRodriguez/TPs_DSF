model Ejercicio4
  PuenteGrua puenteGrua annotation(
    Placement(visible = true, transformation(origin = {-42, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Motor_CC_Exc_Indep motor annotation(
    Placement(visible = true, transformation(origin = {42, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  DSFLib.Mechanical.RotoTranslational.Components.RackPinion rackPinion(r = 0.004)  annotation(
    Placement(visible = true, transformation(origin = {2, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Circuits.Components.ConstVolt constVolt(V = 460)  annotation(
    Placement(visible = true, transformation(origin = {76, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(puenteGrua.flange, rackPinion.flangeT) annotation(
    Line(points = {{-32, 32}, {-10, 32}}));
  connect(motor.flange, rackPinion.flangeR) annotation(
    Line(points = {{32, 40}, {2, 40}}));
  connect(constVolt.n, motor.n) annotation(
    Line(points = {{76, 48}, {52, 48}, {52, 44}}));
  connect(constVolt.p, motor.p) annotation(
    Line(points = {{76, 28}, {52, 28}, {52, 36}}));
end Ejercicio4;
