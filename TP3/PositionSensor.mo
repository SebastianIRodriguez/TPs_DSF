model PositionSensor
  DSFLib.Mechanical.Planar.Interfaces.Flange flange annotation(
    Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Blocks.Interfaces.RealOutput[2] realOutput annotation(
    Placement(visible = true, transformation(origin = {4, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  flange.f = {0, 0};
  realOutput = flange.s;
end PositionSensor;
