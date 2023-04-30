model Exper2
  FromFile table(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper2.txt");
  Real ydata;
  
equation

  ydata = table.ydata;

end Exper2;
