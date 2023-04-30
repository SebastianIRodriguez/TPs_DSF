package Measurements

  model FromFile
    Real ydata;
    parameter String path = "D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper1.txt";
    Modelica.Blocks.Sources.CombiTimeTable table(fileName = path, tableName = "datos", tableOnFile = true);
  equation
    ydata=table.y[1];
  end FromFile;
  
  model Exper1
  FromFile table(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper1.txt");
  Real ydata;
  equation
    ydata = table.ydata;
  end Exper1;
  
  model Exper2
  FromFile table(path="D:/FCEIA/Dinamica de Sistemas Fisicos/TPs_DSF/TP2/exper2.txt");
  Real ydata;
  
  equation
  
    ydata = table.ydata;
  
  end Exper2;

end Measurements;
