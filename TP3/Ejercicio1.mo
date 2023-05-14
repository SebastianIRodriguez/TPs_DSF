model Ejercicio1
  Motor_CC_Exc_Indep motor annotation(
    Placement(visible = true, transformation(origin = {-1, 13}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Damper damper(b = 1.1) annotation(
    Placement(visible = true, transformation(origin = {45, 12}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
    Placement(visible = true, transformation(origin = {84, 12}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  DSFLib.Circuits.Components.ConstVolt ua(V = 460) annotation(
    Placement(visible = true, transformation(origin = {-64, 13}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(ua.p, motor.p) annotation(
    Line(points = {{-64, 23}, {-38, 23}, {-38, 18}, {-12, 18}}));
  connect(ua.n, motor.n) annotation(
    Line(points = {{-64, 3}, {-38, 3}, {-38, 8}, {-12, 8}}));
  connect(inertia.flange, damper.flange_b) annotation(
    Line(points = {{70, 12}, {62, 12}}));
  connect(motor.flange,damper.flange_a) annotation(
    Line(points = {{6, 11}, {28, 11}, {28, 12}}));
end Ejercicio1;
