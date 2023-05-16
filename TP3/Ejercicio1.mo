model Ejercicio1
  Motor_CC_Exc_Indep motor annotation(
    Placement(visible = true, transformation(origin = {-1, 13}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Damper damper(b = 1.1) annotation(
    Placement(visible = true, transformation(origin = {31, -10}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
  DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
    Placement(visible = true, transformation(origin = {84, 14}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  DSFLib.Circuits.Components.ConstVolt ua(V = 460) annotation(
    Placement(visible = true, transformation(origin = {-64, 13}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {30, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ua.p, motor.p) annotation(
    Line(points = {{-64, 23}, {-38, 23}, {-38, 18}, {-12, 18}}));
  connect(ua.n, motor.n) annotation(
    Line(points = {{-64, 3}, {-38, 3}, {-38, 8}, {-12, 8}}));
  connect(fixed.flange, damper.flange_b) annotation(
    Line(points = {{30, -51}, {30, -38.5}, {31, -38.5}, {31, -23}}));
  connect(motor.flange, damper.flange_a) annotation(
    Line(points = {{10, 14}, {31, 14}, {31, 3}}));
  connect(motor.flange, inertia.flange) annotation(
    Line(points = {{10, 14}, {70, 14}}));
end Ejercicio1;
