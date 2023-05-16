model PositionSensor
  DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
  DSFLib.Mechanical.Planar.Interfaces.Flange flange;
equation
  y = l;
  f = 0;
  annotation(
    Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {11, -57}, extent = {{-35, 49}, {35, -49}}, textString = "L"), Polygon(origin = {62, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {1.33523, -20.5966}, points = {{-70, 0}, {70, 0}})}));
end PositionSensor;
