model BouncyBall2D
  BouncyBall ball_x(y0=1.5, v0=-1, g=0);
  BouncyBall ball_y(y0=1.5);
  Real x,y, vx, vy;
equation
  x = ball_x.y;
  y = ball_y.y;
  vx = ball_x.vy;
  vy = ball_y.vy;

end BouncyBall2D;
