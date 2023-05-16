model Ejercicio2
  Motor_CC_Exc_Indep motor annotation(
    Placement(visible = true, transformation(origin = {-1, 13}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Damper damper(b = 1.1) annotation(
    Placement(visible = true, transformation(origin = {35, -20}, extent = {{-17, -17}, {17, 17}}, rotation = -90)));
  ControlledVolt Ua annotation(
    Placement(visible = true, transformation(origin = {-42, 12}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  GenRampa genRampa(Uf = 460, t0 = 5, tf = 10)  annotation(
    Placement(visible = true, transformation(origin = {-82, 12}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
    Placement(visible = true, transformation(origin = {82, 14}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {34, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(genRampa.signal_out, Ua.realInput) annotation(
    Line(points = {{-72, 12}, {-49, 12}}));
  connect(Ua.p, motor.p) annotation(
    Line(points = {{-42, 22}, {-14, 22}, {-14, 18}, {-12, 18}}));
  connect(Ua.n, motor.n) annotation(
    Line(points = {{-42, 2}, {-12, 2}, {-12, 8}}));
  connect(damper.flange_a, motor.flange) annotation(
    Line(points = {{34, -2}, {34, 14}, {10, 14}}));
  connect(motor.flange, inertia.flange) annotation(
    Line(points = {{10, 14}, {68, 14}}));
  connect(fixed.flange, damper.flange_b) annotation(
    Line(points = {{34, -53}, {34, -36}}));
end Ejercicio2;
