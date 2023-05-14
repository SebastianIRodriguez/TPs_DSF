model ControlledVolt
  extends DSFLib.Circuits.Interfaces.OnePort;
  parameter Real V = 1;
  DSFLib.ControlSystems.Blocks.Interfaces.RealInput realInput annotation(
    Placement(visible = true, transformation(origin = {-2, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 72}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  v = realInput;
  annotation(
    Icon(graphics = {Ellipse(extent = {{-78, 80}, {82, -78}}), Line(origin = {-81, 0}, points = {{-3, 0}, {3, 0}, {3, 0}}), Line(origin = {84, 0}, points = {{-2, 0}, {2, 0}, {2, 0}}), Text(origin = {-3, -107}, extent = {{-145, 9}, {145, -9}}, textString = "V=%V"), Line(origin = {-40.2102, -1.19318}, points = {{0, 20}, {0, -20}}), Line(origin = {-40, 0}, points = {{-20, 0}, {20, 0}}), Line(origin = {40.9091, -1.14205}, points = {{0, 21}, {0, -17}})}));
end ControlledVolt;
