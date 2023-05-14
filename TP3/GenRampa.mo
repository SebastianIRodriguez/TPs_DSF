model GenRampa
  parameter Real t0, tf, Uf;
  DSFLib.ControlSystems.Blocks.Interfaces.RealOutput signal_out annotation(
    Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  protected
  Real s;
equation
  s = if time < t0 then
      0
    elseif time > tf then
      Uf 
    else 
      (time - t0) / (tf - t0) * Uf;
  signal_out = s;
end GenRampa;
