model Exper1
  FromFile table(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper1.txt");
  Real ydata;
  
equation

  ydata = table.ydata;

end Exper1;
