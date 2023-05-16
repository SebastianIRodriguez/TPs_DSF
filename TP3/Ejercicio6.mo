model Ejercicio6
  Motor_CC_Exc_Indep motor annotation(
    Placement(visible = true, transformation(origin = {46, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  DSFLib.Mechanical.RotoTranslational.Components.RackPinion rackPinion(r = 0.004)  annotation(
    Placement(visible = true, transformation(origin = {6, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Damper damper(b = 1000000) annotation(
    Placement(visible = true, transformation(origin = {-84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Planar.Components.PointMass carga(m = 4000) annotation(
    Placement(visible = true, transformation(origin = {-40, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Mass carro(m = 1000) annotation(
    Placement(visible = true, transformation(origin = {-40, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {-128, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Planar.Components.PlanarTrans planarTrans annotation(
    Placement(visible = true, transformation(origin = {-38, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Planar.Components.RigidBar cable(L = 10, phi(start = -3.14159/2)) annotation(
    Placement(visible = true, transformation(origin = {-40, -8}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  PositionSensor positionSensor annotation(
    Placement(visible = true, transformation(origin = {4, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  ControlledVolt controlledVolt annotation(
    Placement(visible = true, transformation(origin = {82, 58}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {42, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 30)  annotation(
    Placement(visible = true, transformation(origin = {80, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = 15)  annotation(
    Placement(visible = true, transformation(origin = {4, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(motor.flange, rackPinion.flangeR) annotation(
    Line(points = {{35.8, 58}, {5.8, 58}}));
  connect(fixed.flange, damper.flange_a) annotation(
    Line(points = {{-127.8, 44}, {-127.8, 50}, {-93.8, 50}}));
  connect(cable.flange_a, planarTrans.flangeP) annotation(
    Line(points = {{-40.2, 12.2}, {-40.2, 26.2}}));
  connect(cable.flange_b, carga.flange) annotation(
    Line(points = {{-40.2, -27.8}, {-40.2, -49.8}}));
  connect(planarTrans.flangeT, carro.flange) annotation(
    Line(points = {{-39.5, 34.1}, {-39.5, 44.1}, {-40, 44.1}, {-40, 50.1}}));
  connect(carro.flange, damper.flange_b) annotation(
    Line(points = {{-40.1, 49.9}, {-74.1, 49.9}}));
  connect(carro.flange, rackPinion.flangeT) annotation(
    Line(points = {{-40, 50}, {-6, 50}}));
  connect(carga.flange, positionSensor.flange) annotation(
    Line(points = {{-40, -50}, {-5, -50}}));
  connect(controlledVolt.n, motor.n) annotation(
    Line(points = {{82, 68}, {56, 68}, {56, 62}}));
  connect(controlledVolt.p, motor.p) annotation(
    Line(points = {{82, 48}, {56, 48}, {56, 54}}));
  connect(stepSource.y, add.u1) annotation(
    Line(points = {{16, -12}, {30, -12}, {30, -20}}));
  connect(positionSensor.realOutput[1], add.u2) annotation(
    Line(points = {{14, -50}, {30, -50}, {30, -32}}));
  connect(add.y, gain.u) annotation(
    Line(points = {{54, -26}, {68, -26}}));
  connect(gain.y, controlledVolt.realInput) annotation(
    Line(points = {{92, -26}, {90, -26}, {90, 58}}));
end Ejercicio6;
