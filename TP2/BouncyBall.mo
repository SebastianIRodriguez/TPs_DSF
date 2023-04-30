model BouncyBall
  Boolean contact(start=false);
  Real Fel, Fg, Fam, F, vy(start=v0), v_rel, y(start=y0), y_rel;
  parameter Real m = 0.054, ball_radius = 0.023, b = 1.9, g = 9.8, y0=1.98, v0 = 0;

  FromFile e100cmA(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/100cmA.txt");
  
  FromFile e100cmB(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/100cmB.txt");
    
  FromFile e150cmA(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/150cmA.txt");
  
  FromFile e150cmB(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/150cmB.txt");
  
  FromFile e200cmA(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/200cmA.txt"); 
  //y0 = 1.98 v0 = -1.5
  
  FromFile e200cmB(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/200cmB.txt");
  
equation

  Fam = -b * v_rel;
  Fel = LookUpTable(y_rel);
  F = if contact then Fel + Fam else 0;
  Fg = m*g;
  
  vy = der(y);
  m * der(vy) = F - Fg;
  
  y_rel = ball_radius - y;
  v_rel = vy;
  
algorithm

  when y < ball_radius then
    contact := true;
  end when;
  
  when y > ball_radius then
    contact := false;
  end when;
  
end BouncyBall;
