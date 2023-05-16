model PuenteGrua
  DSFLib.Mechanical.Planar.Components.RigidBar cable(L = 10, phi(start = -3.14159/2))  annotation(
    Placement(visible = true, transformation(origin = {18, 0}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  DSFLib.Mechanical.Planar.Components.PointMass carga(m = 4000)  annotation(
    Placement(visible = true, transformation(origin = {18, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Planar.Components.PlanarTrans planarTrans annotation(
    Placement(visible = true, transformation(origin = {20, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Mass carro(m = 1000)  annotation(
    Placement(visible = true, transformation(origin = {18, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Damper damper(b = 1000000)  annotation(
    Placement(visible = true, transformation(origin = {-26, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {-70, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
    Placement(visible = true, transformation(origin = {88, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(cable.flange_b, carga.flange) annotation(
    Line(points = {{18, -20}, {18, -42}}));
  connect(carro.flange, damper.flange_b) annotation(
    Line(points = {{18, 58}, {-16, 58}}));
  connect(cable.flange_a, planarTrans.flangeP) annotation(
    Line(points = {{18, 20}, {18, 34}}));
  connect(planarTrans.flangeT, carro.flange) annotation(
    Line(points = {{18.5, 42}, {18.5, 52}, {18, 52}, {18, 58}}));
  connect(fixed.flange, damper.flange_a) annotation(
    Line(points = {{-70, 52}, {-70, 58}, {-36, 58}}));
  connect(carro.flange, flange) annotation(
    Line(points = {{18, 58}, {88, 58}}));
end PuenteGrua;
