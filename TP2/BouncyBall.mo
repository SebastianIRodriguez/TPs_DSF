model BouncyBall
  Boolean contact(start=false);
  Real Fel, Fg, Fam, F, vy, v_rel, y(start=2), y_rel;
  parameter Real m = 0.054, ball_radius = 0.023, b = 1, g = 9.8;
  
  FromFile exper1(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper1.txt");
  FromFile exper2(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper2.txt");
  
equation

  Fam = -b * v_rel;
  Fel = LookUpTable(ball_radius - y_rel);
  F = if contact then Fel + Fam else 0;
  Fg = m*g;
  
  vy = der(y);
  m * der(vy) = F - Fg;
  
  y_rel = y;
  v_rel = vy;
  
algorithm

  when y < ball_radius then
    contact := true;
  end when;
  
  when y > ball_radius then
    contact := false;
  end when;
  
end BouncyBall;
