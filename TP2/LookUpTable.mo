function LookUpTable

  input Real x;
  output Real y;
  
  protected
  parameter Real xdata[:]={
    0,
    0.00015875,
    0.0003175,
    0.00047625,
    0.000635,
    0.00079375,
    0.0009525,
    0.00111125,
    0.00127
  };
  parameter Real ydata[:]={
    0,
    0.9898,
    2.1658,
    3.5574,
    5.6154,
    8.1046,
    10.8878,
    14.0728,
    17.444
  };
  Integer k;
    
  algorithm
    k:=1;
    while x>xdata[k+1] and k<size(xdata,1)-1 loop
      k:=k+1;
    end while;
    y:=(ydata[k+1]-ydata[k])/(xdata[k+1]-xdata[k])*(x-xdata[k])+ydata[k];
    
end LookUpTable;
