package DSFLib
  package Circuits
    package Units
      type Voltage = Real(unit = "V");
      type Current = Real(unit = "A");
    end Units;

    package Interfaces
      import DSFLib.Circuits.Units.*;

      connector Pin
        Voltage v;
        flow Current i;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
      end Pin;

      partial model OnePort
        Pin p annotation(
          Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Pin n annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Voltage v;
        Current i;
      equation
        v = p.v - n.v;
        p.i = i;
        n.i + p.i = 0;
      end OnePort;
    end Interfaces;

    package Components
      import DSFLib.Circuits.Interfaces.*;

      model Ground
        Pin p annotation(
          Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, 77}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
      equation
        p.v = 0;
        annotation(
          Icon(graphics = {Line(origin = {0, 20}, points = {{-100, 0}, {100, 0}}), Line(origin = {0, -20}, points = {{-60, 0}, {60, 0}}), Line(origin = {0, -60}, points = {{-20, 0}, {20, 0}}), Line(origin = {0, 37}, points = {{0, 17}, {0, -17}})}, coordinateSystem(initialScale = 0.1)));
      end Ground;

      model Resistor
        extends OnePort;
        parameter Real R(unit = "Ohm") = 1;
      equation
        v - R * i = 0;
        annotation(
          Icon(graphics = {Line(points = {{-84, 0}, {-70, 0}, {-60, -60}, {-42, 60}, {-20, -60}, {0, 60}, {20, -62}, {40, 62}, {60, -60}, {72, 0}, {84, 0}, {84, 0}}), Text(origin = {14, 95}, extent = {{-122, 25}, {94, -37}}, textString = "R=%R")}, coordinateSystem(initialScale = 0.1)));
      end Resistor;

      model Capacitor
        extends OnePort;
        parameter Real C(unit = "F") = 1;
      equation
        C * der(v) - i = 0;
        annotation(
          Icon(graphics = {Line(origin = {-52.5966, -0.500001}, points = {{-32, 0.5}, {32, 0.5}, {32, 80.5}, {32, -79.5}, {32, -79.5}}), Line(origin = {52, -0.5}, points = {{32, 0.5}, {-32, 0.5}, {-32, 80.5}, {-32, -79.5}, {-32, -79.5}}), Text(origin = {14, 107}, extent = {{-118, 29}, {86, -33}}, textString = "C=%C")}, coordinateSystem(initialScale = 0.1)));
      end Capacitor;

      model Inductor
        extends OnePort;
        parameter Real L(unit = "Hy") = 1;
      equation
        L * der(i) - v = 0;
        annotation(
          Icon(graphics = {Line(points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {30.2841, -0.142045}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {60.1136, -0.142045}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {90.3977, -0.28409}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-72, 0}, points = {{-12, 0}, {12, 0}, {12, 0}}), Line(origin = {72, 0}, points = {{-12, 0}, {12, 0}, {12, 0}}), Text(origin = {12, 89}, extent = {{-64, 41}, {64, -41}}, textString = "L=%L")}));
      end Inductor;

      model Diode
        extends OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5, Vknee = 0.6;
      equation
        i = if v > Vknee then (v - Vknee) / Ron + Vknee / Roff else v / Roff;
        annotation(
          Icon(graphics = {Line(origin = {1, 0}, points = {{-83, 0}, {83, 0}, {83, 0}}), Polygon(origin = {11, 0}, fillPattern = FillPattern.Solid, points = {{-31, 40}, {-31, -40}, {31, 0}, {-31, 40}, {-31, 40}}), Line(origin = {40, -1}, points = {{0, 41}, {0, -39}, {0, -39}})}));
      end Diode;

      model Switch
        extends OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5;
        discrete Real s;
      equation
        v = if s > 0.5 then i * Ron else i * Roff;
        annotation(
          Icon(graphics = {Line(origin = {-29.7929, 21.2071}, points = {{-52.2071, -21.2071}, {9.79289, -21.2071}, {51.7929, 20.7929}, {51.7929, 20.7929}}), Line(origin = {52, 0}, points = {{-32, 0}, {32, 0}, {32, 0}})}));
      end Switch;

      model ConstCurr
        extends OnePort;
        parameter Real I = 1;
      equation
        i = -I;
        annotation(
          Icon(graphics = {Ellipse(extent = {{-78, 80}, {82, -78}}), Line(origin = {-0.117647, 0}, points = {{-50, 0}, {50, 0}, {50, 0}}), Line(origin = {-81, 0}, points = {{-3, 0}, {3, 0}, {3, 0}}), Line(origin = {84, 0}, points = {{-2, 0}, {2, 0}, {2, 0}}), Line(origin = {-35.6, -1.00112}, points = {{15.6, 25.0011}, {-16.4, 1.00112}, {15.6, -22.9989}, {15.6, -22.9989}}), Text(origin = {-3, -107}, extent = {{-145, 9}, {145, -9}}, textString = "I=%I")}));
      end ConstCurr;

      model ConstVolt
        extends OnePort;
        parameter Real V = 1;
      equation
        v = V;
        annotation(
          Icon(graphics = {Ellipse(extent = {{-78, 80}, {82, -78}}), Line(origin = {-81, 0}, points = {{-3, 0}, {3, 0}, {3, 0}}), Line(origin = {84, 0}, points = {{-2, 0}, {2, 0}, {2, 0}}), Text(origin = {-3, -107}, extent = {{-145, 9}, {145, -9}}, textString = "V=%V"), Line(origin = {-40.2102, -1.19318}, points = {{0, 20}, {0, -20}}), Line(origin = {-40, 0}, points = {{-20, 0}, {20, 0}}), Line(origin = {40.9091, -1.14205}, points = {{0, 21}, {0, -17}})}));
      end ConstVolt;

      model NLInductor
        extends OnePort;
        parameter Real[:] currTable = {-2, -1, 0, 1, 2};
        parameter Real[:] fluxTable = {-2, -1, 0, 1, 2};
        Real phi(unit = "V.s");
      equation
        der(phi) = v;
        phi = DSFLib.Utilities.Functions.LookUpTable(i, currTable, fluxTable);
        annotation(
          Icon(graphics = {Line(points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {30.2841, -0.142045}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {60.1136, -0.142045}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {90.3977, -0.28409}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-72, 0}, points = {{-12, 0}, {12, 0}, {12, 0}}), Line(origin = {72, 0}, points = {{-12, 0}, {12, 0}, {12, 0}}), Line(origin = {-1.78977, 80.2841}, points = {{-60, 0}, {60, 0}}), Line(origin = {0.596594, 60.5966}, points = {{-60, 0}, {60, 0}})}));
      end NLInductor;
    end Components;

    package Examples
      import DSFLib.Circuits.Components.*;

      model RLC
        Resistor res(R = 0.1) annotation(
          Placement(visible = true, transformation(origin = {10, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        Ground gr annotation(
          Placement(visible = true, transformation(origin = {-12, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Capacitor cap(v(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {40, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Inductor ind annotation(
          Placement(visible = true, transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(ind.n, res.p) annotation(
          Line(points = {{-20, 60}, {-2, 60}}));
        connect(res.n, cap.p) annotation(
          Line(points = {{22, 60}, {40, 60}, {40, 40}}));
        connect(cap.n, gr.p) annotation(
          Line(points = {{40, 20}, {40, 0}, {-12, 0}}));
        connect(ind.p, gr.p) annotation(
          Line(points = {{-40, 60}, {-60, 60}, {-60, 0}, {-12, 0}}));
      end RLC;

      package Panels
        model Panel
          DSFLib.Circuits.Components.Diode dio annotation(
            Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Resistor rs(R = 0.35) annotation(
            Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor rsh(R = 200) annotation(
            Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {100, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstCurr cc annotation(
            Placement(visible = true, transformation(origin = {-64, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(dio.p, rs.p) annotation(
            Line(points = {{-40, 10}, {-40, 10}, {-40, 20}, {0, 20}, {0, 20}}));
          connect(rsh.p, rs.p) annotation(
            Line(points = {{-20, 10}, {-20, 10}, {-20, 20}, {0, 20}, {0, 20}}));
          connect(rs.n, p) annotation(
            Line(points = {{20, 20}, {60, 20}, {60, 60}, {94, 60}, {94, 58}, {100, 58}}));
          connect(cc.p, rs.p) annotation(
            Line(points = {{-64, 10}, {-64, 10}, {-64, 20}, {0, 20}, {0, 20}}));
          connect(cc.n, n) annotation(
            Line(points = {{-64, -10}, {-64, -20}, {60, -20}, {60, -60}, {98, -60}}));
          connect(dio.n, cc.n) annotation(
            Line(points = {{-40, -10}, {-40, -10}, {-40, -20}, {-64, -20}, {-64, -10}, {-64, -10}}));
          connect(rsh.n, dio.n) annotation(
            Line(points = {{-20, -10}, {-20, -10}, {-20, -20}, {-40, -20}, {-40, -10}, {-40, -10}}));
        protected
          annotation(
            Diagram,
            Icon(graphics = {Rectangle(origin = {-19, 1}, fillColor = {234, 234, 234}, fillPattern = FillPattern.Solid, extent = {{-119, 95}, {119, -95}}), Bitmap(origin = {8, 0}, extent = {{-140, 76}, {94, -64}}, imageSource = "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")}));
        end Panel;

        model TwoPanels
          DSFLib.Circuits.Examples.Panels.Panel panel1 annotation(
            Placement(visible = true, transformation(origin = {-39, 47}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
          DSFLib.Circuits.Examples.Panels.Panel panel annotation(
            Placement(visible = true, transformation(origin = {-39, -29}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {20, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor rl annotation(
            Placement(visible = true, transformation(origin = {48, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Capacitor capacitor annotation(
            Placement(visible = true, transformation(origin = {82, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(panel1.n, panel.p) annotation(
            Line(points = {{-10, 30}, {6, 30}, {6, -12}, {-10, -12}, {-10, -12}}));
          connect(panel1.p, rl.p) annotation(
            Line(points = {{-10, 64}, {48, 64}, {48, 22}, {48, 22}}));
          connect(rl.n, ground.p) annotation(
            Line(points = {{48, 2}, {48, 2}, {48, -60}, {20, -60}, {20, -60}}));
          connect(panel.n, ground.p) annotation(
            Line(points = {{-10, -46}, {0, -46}, {0, -60}, {20, -60}, {20, -60}}));
          connect(panel1.p, capacitor.p) annotation(
            Line(points = {{-10, 64}, {82, 64}, {82, 22}, {82, 22}}));
          connect(ground.p, capacitor.n) annotation(
            Line(points = {{20, -60}, {82, -60}, {82, 2}, {82, 2}}));
        end TwoPanels;
      end Panels;
    end Examples;
  end Circuits;

  package Mechanical
    package Translational
      package Units
        type Position = Real(unit = "m");
        type Force = Real(unit = "N");
      end Units;

      package Interfaces
        import DSFLib.Mechanical.Translational.Units.*;

        connector Flange
          Position s;
          flow Force f;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {0, 118, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
        end Flange;

        partial model Compliant
          Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {96, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Position s_rel;
          Force f;
        equation
          s_rel = flange_b.s - flange_a.s;
          flange_b.f = f;
          flange_a.f = -f;
        end Compliant;
      end Interfaces;

      package Components
        import DSFLib.Mechanical.Translational.Units.*;
        import DSFLib.Mechanical.Translational.Interfaces.*;

        model Fixed
          Flange flange annotation(
            Placement(visible = true, transformation(origin = {2, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Position s_0 = 0;
        equation
          flange.s = s_0;
          annotation(
            Icon(graphics = {Line(origin = {-1, 1.2}, points = {{0.997353, 40.8012}, {-59.0026, -41.1988}, {60.9974, -41.1988}, {2.99735, 38.8012}, {2.99735, 38.8012}}, color = {0, 170, 0}), Line(origin = {-90, -50}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-71.0512, -49.5454}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-50.1705, -49.5455}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-31.2217, -49.0909}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-10.1989, -50.142}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {8.74994, -49.6874}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {29.6306, -49.6875}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {48.5794, -49.2329}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {70.3409, -51.3352}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {89.2897, -50.8806}, points = {{10, 10}, {-10, -10}, {-10, -10}})}, coordinateSystem(initialScale = 0.1)));
        end Fixed;

        model Mass
          Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1;
          Position s;
          Real v(unit = "m/s");
          Force f;
        equation
          s = flange.s;
          f = flange.f;
          m * der(v) - f = 0;
          der(s) - v = 0;
          annotation(
            Icon(graphics = {Ellipse(fillColor = {0, 255, 0}, fillPattern = FillPattern.Sphere, extent = {{-98, 98}, {98, -98}}, endAngle = 360), Text(origin = {-2, 124}, extent = {{-96, 16}, {96, -16}}, textString = "m=%m")}, coordinateSystem(initialScale = 0.1)));
        end Mass;

        model Spring
          extends Compliant;
          parameter Real k(unit = "N/m") = 1;
          parameter Position s_rel0 = 0;
        equation
          f = k * (s_rel - s_rel0);
          annotation(
            Icon(graphics = {Line(origin = {-1.92, 0.01}, points = {{-84.0754, -0.0144623}, {-68.0754, -0.0144623}, {-58.0754, 39.9855}, {-38.0754, -38.0145}, {-18.0754, 39.9855}, {-0.0753965, -38.0145}, {21.9246, 39.9855}, {41.9246, -40.0145}, {61.9246, 39.9855}, {71.9246, -0.01446}, {83.9246, -0.0144623}, {83.9246, -0.0144623}}, color = {0, 170, 0}), Text(origin = {-2, 80}, extent = {{-96, 16}, {96, -16}}, textString = "k=%k")}, coordinateSystem(initialScale = 0.1)));
        end Spring;

        model Damper
          extends Compliant;
          parameter Real b(unit = "N.s/m") = 1;
        equation
          f = b * der(s_rel);
          annotation(
            Icon(graphics = {Line(origin = {-13, 30}, points = {{-73, -30}, {-47, -30}, {-47, 30}, {73, 30}, {73, 30}}, color = {0, 170, 0}), Line(origin = {0, -31}, points = {{-60, 29}, {-60, -29}, {60, -29}, {60, -29}}, color = {0, 170, 0}), Line(origin = {42, 1.5}, points = {{42, -1.5}, {-42, -1.5}, {-42, 50.5}, {-42, -49.5}, {-42, -49.5}}, color = {0, 170, 0}), Text(origin = {-2, 106}, extent = {{-96, 16}, {96, -16}}, textString = "b=%b")}, coordinateSystem(initialScale = 0.1)));
        end Damper;

        model ConstForce
          DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, 1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Force F = 1;
        equation
          flange.f = -F;
          annotation(
            Diagram,
            Icon(graphics = {Line(origin = {6.78, -0.28}, points = {{-92.7774, 0.27735}, {93.2226, 0.27735}, {33.2226, 40.2774}, {93.2226, 0.27735}, {33.2226, -39.7226}}, color = {0, 170, 0}), Text(origin = {-4, 83}, extent = {{-104, 13}, {104, -13}}, textString = "F=%F")}));
        end ConstForce;
      end Components;

      package Examples
        import DSFLib.Mechanical.Translational.Components.*;

        model SpringMass
          Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mass mass(s(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Spring spring annotation(
            Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{2, 0}, {34, 0}}));
          connect(spring.flange_b, mass.flange) annotation(
            Line(points = {{54, 0}, {82, 0}}));
        end SpringMass;

        model SpringDamperMass
          Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mass mass(m = 10, s(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Spring spring annotation(
            Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Damper damper annotation(
            Placement(visible = true, transformation(origin = {42, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{2, 0}, {34, 0}}));
          connect(spring.flange_b, mass.flange) annotation(
            Line(points = {{54, 0}, {82, 0}}));
          connect(damper.flange_b, spring.flange_b) annotation(
            Line(points = {{52, 30}, {64, 30}, {64, 0}, {54, 0}}));
          connect(damper.flange_a, spring.flange_a) annotation(
            Line(points = {{32, 30}, {24, 30}, {24, 0}, {34, 0}}));
        end SpringDamperMass;
      end Examples;
    end Translational;

    package Rotational
      package Units
        type Angle = Real(unit = "rad");
        type Torque = Real(unit = "N.m");
      end Units;

      package Interfaces
        import DSFLib.Mechanical.Rotational.Units.*;

        connector Flange
          Angle phi;
          flow Torque tau;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(origin = {-1, 0}, fillColor = {193, 193, 193}, fillPattern = FillPattern.Solid, extent = {{-99, 100}, {99, -100}}, endAngle = 360)}));
        end Flange;

        partial model Compliant
          Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {96, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Angle phi_rel;
          Torque tau;
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          flange_b.tau = tau;
          flange_a.tau = -tau;
        end Compliant;
      end Interfaces;

      package Components
        import DSFLib.Mechanical.Rotational.Units.*;
        import DSFLib.Mechanical.Rotational.Interfaces.*;

        model Fixed
          parameter Angle phi_0 = 0;
          Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        equation
          flange.phi = phi_0;
          annotation(
            Icon(graphics = {Line(origin = {-0.997353, 1.19884}, points = {{0.997353, 40.8012}, {-59.0026, -41.1988}, {60.9974, -41.1988}, {2.99735, 38.8012}, {2.99735, 38.8012}}), Line(origin = {-90, -50}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-71.0512, -49.5454}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-50.1705, -49.5455}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-31.2217, -49.0909}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-10.1989, -50.142}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {8.74994, -49.6874}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {29.6306, -49.6875}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {48.5794, -49.2329}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {70.3409, -51.3352}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {89.2897, -50.8806}, points = {{10, 10}, {-10, -10}, {-10, -10}})}));
        end Fixed;

        model Inertia
          Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-99, 1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real J(unit = "Kg.m^2") = 1;
          Angle phi;
          Real w(unit = "rad/s");
          Torque tau;
        equation
          phi = flange.phi;
          tau = flange.tau;
          J * der(w) - tau = 0;
          der(phi) - w = 0;
          annotation(
            Icon(graphics = {Text(origin = {-2, 124}, extent = {{-96, 16}, {96, -16}}, textString = "J=%J"), Rectangle(origin = {11, -3}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-41, 103}, {31, -95}}, radius = 20), Rectangle(origin = {-3, 63}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-97, -49}, {-27, -77}})}, coordinateSystem(initialScale = 0.1)));
        end Inertia;

        model Spring
          extends Compliant;
          parameter Real k(unit = "N.m/rad") = 1;
          parameter Angle phi_rel0 = 0;
        equation
          tau = k * (phi_rel - phi_rel0);
          annotation(
            Icon(graphics = {Line(origin = {-1.9246, 0.0144623}, points = {{-84.0754, -0.0144623}, {-68.0754, -0.0144623}, {-58.0754, 39.9855}, {-38.0754, -38.0145}, {-18.0754, 39.9855}, {-0.0753965, -38.0145}, {21.9246, 39.9855}, {41.9246, -40.0145}, {61.9246, 39.9855}, {71.9246, -0.01446}, {83.9246, -0.0144623}, {83.9246, -0.0144623}}), Text(origin = {-2, 80}, extent = {{-96, 16}, {96, -16}}, textString = "k=%k")}));
        end Spring;

        model Damper
          extends Compliant;
          parameter Real b(unit = "N.m.s/rad") = 1;
        equation
          tau = b * der(phi_rel);
          annotation(
            Icon(graphics = {Line(origin = {-13, 30}, points = {{-73, -30}, {-47, -30}, {-47, 30}, {73, 30}, {73, 30}}), Line(origin = {0, -31}, points = {{-60, 29}, {-60, -29}, {60, -29}, {60, -29}}), Line(origin = {42, 1.5}, points = {{42, -1.5}, {-42, -1.5}, {-42, 50.5}, {-42, -49.5}, {-42, -49.5}}), Text(origin = {-2, 106}, extent = {{-96, 16}, {96, -16}}, textString = "b=%b")}));
        end Damper;
      end Components;

      package Examples
        import DSFLib.Mechanical.Rotational.Components.*;

        model SpringDamperInertia
          Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-14, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Inertia inertia(phi(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {46, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Spring spring annotation(
            Placement(visible = true, transformation(origin = {2, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Damper damper annotation(
            Placement(visible = true, transformation(origin = {4, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(damper.flange_b, inertia.flange) annotation(
            Line(points = {{14, 22}, {36, 22}, {36, 36}, {36, 36}}));
          connect(spring.flange_b, inertia.flange) annotation(
            Line(points = {{12, 52}, {36, 52}, {36, 36}, {36, 36}}));
          connect(spring.flange_a, fixed.flange) annotation(
            Line(points = {{-8, 52}, {-14, 52}, {-14, -10}, {-14, -10}}));
          connect(damper.flange_a, fixed.flange) annotation(
            Line(points = {{-6, 22}, {-14, 22}, {-14, -10}, {-14, -10}}));
        end SpringDamperInertia;
      end Examples;
    end Rotational;

    package RotoTranslational
      package Components
        model RackPinion
          DSFLib.Mechanical.Translational.Interfaces.Flange flangeT annotation(
            Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-117, -59}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flangeR annotation(
            Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, 29}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real r(unit = "m") = 1 "Pinion radius";
          parameter Real s_0(unit="m") = 0 "Position s when angle phi=0";
        equation
          flangeT.s - s_0 = r * flangeR.phi;
          r * flangeT.f = -flangeR.tau;
          annotation(
            Icon(graphics = {Ellipse(origin = {1, 30}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{-67, 70}, {67, -70}}), Rectangle(origin = {6, -58}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{92, 18}, {-92, -18}}), Line(origin = {-92, -60}, points = {{6, 0}, {-6, 0}, {6, 0}})}));
        end RackPinion;
      end Components;

      package Examples
        model RotTrans
          DSFLib.Mechanical.RotoTranslational.Components.RackPinion rackPinion annotation(
            Placement(visible = true, transformation(origin = {8, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-88, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Rotational.Components.Inertia inertia(phi(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {38, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Fixed fixed1 annotation(
            Placement(visible = true, transformation(origin = {86, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.Mechanical.Rotational.Components.Spring spring annotation(
            Placement(visible = true, transformation(origin = {62, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Damper damper annotation(
            Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Mass mass annotation(
            Placement(visible = true, transformation(origin = {-20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(rackPinion.flangeR, inertia.flange) annotation(
            Line(points = {{8, 18}, {28, 18}, {28, 34}}));
          connect(inertia.flange, spring.flange_a) annotation(
            Line(points = {{28, 34}, {52, 34}}));
          connect(spring.flange_b, fixed1.flange) annotation(
            Line(points = {{72, 34}, {80, 34}}));
          connect(damper.flange_a, fixed.flange) annotation(
            Line(points = {{-70, 10}, {-88, 10}}));
          connect(mass.flange, rackPinion.flangeT) annotation(
            Line(points = {{-20, 10}, {-4, 10}}));
          connect(damper.flange_b, mass.flange) annotation(
            Line(points = {{-50, 10}, {-20, 10}}));
        end RotTrans;
      end Examples;
    end RotoTranslational;

    package Planar
      package Units
        type Position = DSFLib.Mechanical.Translational.Units.Position[2];
        type Force = DSFLib.Mechanical.Translational.Units.Force[2];
      end Units;

      package Interfaces
        import DSFLib.Mechanical.Planar.Units.*;

        connector Flange
          Position s;
          flow Force f;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
        end Flange;

        partial model Compliant
          DSFLib.Mechanical.Planar.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Real l(unit = "m");
          Real phi(unit = "rad", stateSelect = StateSelect.prefer);
          Real w(unit = "rad/s");
          Real f(unit = "N");
        equation
          flange_b.s[1] - flange_a.s[1] = l * cos(phi);
          flange_b.s[2] - flange_a.s[2] = l * sin(phi);
          der(phi) = w;
          flange_a.f = -flange_b.f;
          flange_b.f[1] = f * cos(phi);
          flange_b.f[2] = f * sin(phi);
        end Compliant;
        annotation(
          Icon);
      end Interfaces;

      package Components
        import DSFLib.Mechanical.Planar.Units.*;
        import DSFLib.Mechanical.Planar.Interfaces.*;

        model PointMass
          DSFLib.Mechanical.Planar.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 2.66454e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1;
          parameter Real[2] g(each unit = "m/s^2") = {0, -9.8};
          Position s;
          Real[2] v(each unit = "m/s");
          Force f;
        equation
          s = flange.s;
          f = flange.f;
          m * der(v) = f + m * g;
          der(s) = v;
          annotation(
            Icon(graphics = {Ellipse(fillColor = {255, 0, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}}, endAngle = 360), Text(origin = {-11, 113}, extent = {{-89, 15}, {109, -15}}, textString = "m=%m")}, coordinateSystem(initialScale = 0.1)));
        end PointMass;

        model Fixed
          DSFLib.Mechanical.Planar.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, 59}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
          parameter Position s_0 = {0, 0};
        equation
          flange.s = s_0;
          annotation(
            Icon(graphics = {Line(origin = {89.2897, -50.8806}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-10.1989, -50.142}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {29.6306, -49.6875}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-90, -50}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {8.74994, -49.6874}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-31.2217, -49.0909}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-1, 1.2}, points = {{0.997353, 40.8012}, {-59.0026, -41.1988}, {60.9974, -41.1988}, {2.99735, 38.8012}, {2.99735, 38.8012}}, color = {170, 0, 255}), Line(origin = {70.3409, -51.3352}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-71.0512, -49.5454}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {-50.1705, -49.5455}, points = {{10, 10}, {-10, -10}, {-10, -10}}), Line(origin = {48.5794, -49.2329}, points = {{10, 10}, {-10, -10}, {-10, -10}})}));
        end Fixed;

        model ConstForce
          DSFLib.Mechanical.Planar.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-79, -3}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          parameter Force f = {1, 0};
        equation
          flange.f = -f;
          annotation(
            Icon(graphics = {Line(origin = {19.85, -10.26}, points = {{-79.8536, 10.2599}, {80.1464, 10.2599}, {40.1464, 30.2599}, {80.1464, 10.2599}, {40.1464, -9.7401}, {40.1464, -9.7401}}, color = {170, 0, 255}, thickness = 0.5), Text(origin = {9, 64}, extent = {{-157, 10}, {133, -2}}, textString = "f=%f")}, coordinateSystem(initialScale = 0.1)));
        end ConstForce;

        model RigidBar
          extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
          parameter Real L(unit = "m") = 1;
        equation
          l = L;
          annotation(
            Icon(graphics = {Rectangle(origin = {-1, -1}, fillColor = {170, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-85, 5}, {85, -5}}), Text(origin = {3, 38}, extent = {{-99, 14}, {97, -8}}, textString = "L=%L")}, coordinateSystem(initialScale = 0.1)));
        end RigidBar;

        model Spring
          extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
          parameter Real k(unit = "N/m") = 1;
          parameter Real l0(unit = "m") = 1;
        equation
          f = k * (l - l0);
          annotation(
            Icon(graphics = {Line(origin = {-1.92, 0.01}, points = {{-84.0754, -0.0144623}, {-68.0754, -0.0144623}, {-58.0754, 39.9855}, {-38.0754, -38.0145}, {-18.0754, 39.9855}, {-0.0753965, -38.0145}, {21.9246, 39.9855}, {41.9246, -40.0145}, {61.9246, 39.9855}, {71.9246, -0.01446}, {83.9246, -0.0144623}, {83.9246, -0.0144623}}, color = {170, 0, 255}), Text(origin = {9, 74}, extent = {{-97, 16}, {97, -16}}, textString = "k=%k")}, coordinateSystem(initialScale = 0.1)));
        end Spring;

        model Damper
          extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
          parameter Real b(unit = "N.s/m") = 1;
        equation
          f = b * der(l);
          annotation(
            Icon(graphics = {Line(origin = {-13, 30}, points = {{-73, -30}, {-47, -30}, {-47, 30}, {73, 30}, {73, 30}}, color = {170, 0, 255}), Line(origin = {42, 1.5}, points = {{42, -1.5}, {-42, -1.5}, {-42, 50.5}, {-42, -49.5}, {-42, -49.5}}, color = {170, 0, 255}), Line(origin = {-0.6, -30.4}, points = {{-60, 29}, {-60, -29}, {60, -29}, {60, -29}}, color = {170, 0, 255}), Text(origin = {11, 90}, extent = {{-111, 14}, {111, -14}}, textString = "b=%b")}, coordinateSystem(initialScale = 0.1)));
        end Damper;

        model PlanarTrans
          DSFLib.Mechanical.Planar.Interfaces.Flange flangeP annotation(
            Placement(visible = true, transformation(origin = {-32, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-16, -2.22045e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Interfaces.Flange flangeT annotation(
            Placement(visible = true, transformation(origin = {98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-15, 81}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real phi(unit = "rad") = 0 "Translational system angle";
          parameter Position s_0 = {0,0} "Planar position of translational origin";
        equation
          flangeP.s[1] = flangeT.s * cos(phi)+s_0[1];
          flangeP.s[2] = flangeT.s * sin(phi)+s_0[2];
          flangeP.f[1] * cos(phi) + flangeP.f[2] * sin(phi) + flangeT.f = 0;
          annotation(
            Icon(graphics = {Line(origin = {0, 39.6875}, points = {{-100, 0}, {100, 0}, {100, 0}}, thickness = 0.5), Line(origin = {1.79, -36.7045}, points = {{-102, 0}, {98, 0}}, thickness = 0.5), Rectangle(origin = {-1, -1}, fillColor = {170, 0, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-99, 9}, {99, -9}}), Rectangle(origin = {-14, 41}, extent = {{-2, 25}, {2, -25}})}));
        end PlanarTrans;

        model PlanarRot
          DSFLib.Mechanical.Planar.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {59, 77}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {0, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {17, 17}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flangeR annotation(
            Placement(visible = true, transformation(extent = {{0, 0}, {0, 0}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          parameter Real r(unit = "m") = 1 "Radius";
          Real phi(unit = "rad", stateSelect = StateSelect.prefer);
          Real w(unit = "rad/s");
        equation
          flange_b.s[1] - flange_a.s[1] = r * cos(flangeR.phi);
          flange_b.s[2] - flange_a.s[2] = r * sin(flangeR.phi);
          flange_a.f = -flange_b.f;
          flange_b.f[1] * sin(flangeR.phi) - flange_b.f[2] * cos(flangeR.phi) - flangeR.tau = 0;
          phi = flangeR.phi;
          der(phi) = w;
          annotation(
            Icon(graphics = {Ellipse(origin = {0, -1}, fillColor = {236, 236, 236}, fillPattern = FillPattern.Solid, extent = {{-100, 99}, {100, -99}})}));
        end PlanarRot;
      end Components;

      package Examples
        model MassForce
          Components.PointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.ConstForce constForce annotation(
            Placement(visible = true, transformation(origin = {32, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(pointMass.flange, constForce.flange) annotation(
            Line(points = {{0, 30}, {24, 30}}));
        end MassForce;

        model Pendulum
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi(start = -1)) annotation(
            Placement(visible = true, transformation(origin = {0, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Components.PointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(rigidBar.flange_a, fixed.flange) annotation(
            Line(points = {{0, 72}, {0, 82}}));
          connect(rigidBar.flange_b, pointMass.flange) annotation(
            Line(points = {{0, 52}, {0, 24}}));
        end Pendulum;

        model DoublePendulum
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi(start = -1)) annotation(
            Placement(visible = true, transformation(origin = {0, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.PointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar1 annotation(
            Placement(visible = true, transformation(origin = {30, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.PointMass pointMass1 annotation(
            Placement(visible = true, transformation(origin = {30, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(rigidBar.flange_a, fixed.flange) annotation(
            Line(points = {{0, 72}, {0, 82}}));
          connect(rigidBar.flange_b, pointMass.flange) annotation(
            Line(points = {{0, 52}, {0, 24}}));
          connect(rigidBar1.flange_b, pointMass1.flange) annotation(
            Line(points = {{30, 4}, {30, -24}}));
          connect(rigidBar1.flange_a, pointMass.flange) annotation(
            Line(points = {{30, 24}, {2, 24}, {2, 24}, {0, 24}}));
        end DoublePendulum;

        model SpringPendulum
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.PointMass pointMass(s(start = {0.5, -0.5})) annotation(
            Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Spring spring(k = 100) annotation(
            Placement(visible = true, transformation(origin = {0, 56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{0, 82}, {0, 66}}));
          connect(spring.flange_b, pointMass.flange) annotation(
            Line(points = {{0, 46}, {0, 24}}));
        protected
        end SpringPendulum;

        model BridgeCrane
          DSFLib.Mechanical.Planar.Components.PlanarTrans planarTrans annotation(
            Placement(visible = true, transformation(origin = {-8, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.PointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {-10, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Mass mass annotation(
            Placement(visible = true, transformation(origin = {-10, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi(start = -1)) annotation(
            Placement(visible = true, transformation(origin = {-10, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(rigidBar.flange_a, planarTrans.flangeP) annotation(
            Line(points = {{-10, 36}, {-10, 44}}));
          connect(rigidBar.flange_b, pointMass.flange) annotation(
            Line(points = {{-10.1, 16.1}, {-10.1, -1.9}}));
          connect(planarTrans.flangeT, mass.flange) annotation(
            Line(points = {{-10, 48}, {-10, 62}}));
        end BridgeCrane;

        model RotoPlanar
          Components.PlanarRot planarRot annotation(
            Placement(visible = true, transformation(origin = {0, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {2, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(phi(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {18, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Fixed fixed1 annotation(
            Placement(visible = true, transformation(origin = {-42, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Rotational.Components.Spring spring1 annotation(
            Placement(visible = true, transformation(origin = {-18, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Damper damper annotation(
            Placement(visible = true, transformation(origin = {54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed2(s_0 = {2, 0}) annotation(
            Placement(visible = true, transformation(origin = {56, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.PointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {62, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.ConstForce constForce(f = {0, -9.8}) annotation(
            Placement(visible = true, transformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(inertia.flange, planarRot.flangeR) annotation(
            Line(points = {{8, 50}, {0, 50}, {0, 24}}));
          connect(fixed1.flange, spring1.flange_a) annotation(
            Line(points = {{-36, 52}, {-28, 52}}));
          connect(spring1.flange_b, inertia.flange) annotation(
            Line(points = {{-8, 52}, {8, 52}, {8, 50}}));
          connect(planarRot.flange_a, fixed.flange) annotation(
            Line(points = {{2, 26}, {2, -4}}));
          connect(damper.flange_b, fixed2.flange) annotation(
            Line(points = {{54, -12}, {54, -27}, {56, -27}, {56, -44}}));
          connect(planarRot.flange_b, pointMass.flange) annotation(
            Line(points = {{6, 32}, {31, 32}, {31, 38}, {62, 38}}));
          connect(damper.flange_a, pointMass.flange) annotation(
            Line(points = {{54, 8}, {54, 25}, {62, 25}, {62, 38}}));
          connect(constForce.flange, pointMass.flange) annotation(
            Line(points = {{86, 12}, {62, 12}, {62, 38}}));
        end RotoPlanar;

        model SliderCrank
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-44, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.PlanarRot planarRot(r = 0.1) annotation(
            Placement(visible = true, transformation(origin = {-44, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar annotation(
            Placement(visible = true, transformation(origin = {-1, 23}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.PlanarTrans planarTrans annotation(
            Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(w(start = 1, stateSelect = StateSelect.always)) annotation(
            Placement(visible = true, transformation(origin = {-74, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Translational.Components.Mass mass annotation(
            Placement(visible = true, transformation(origin = {56, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(planarRot.flange_b, rigidBar.flange_a) annotation(
            Line(points = {{-38, 30}, {-16, 30}, {-16, 23}}));
          connect(rigidBar.flange_b, planarTrans.flangeP) annotation(
            Line(points = {{14, 23}, {14, 0}, {30, 0}}));
          connect(fixed.flange, planarRot.flange_a) annotation(
            Line(points = {{-44, -4}, {-42, -4}, {-42, 24}}));
          connect(inertia.flange, planarRot.flangeR) annotation(
            Line(points = {{-64, 22}, {-44, 22}, {-44, 22}, {-44, 22}}));
          connect(planarTrans.flangeT, mass.flange) annotation(
            Line(points = {{30, 8}, {56, 8}}));
        end SliderCrank;
      end Examples;
    end Planar;
  end Mechanical;

  package Hydraulics
    package Units
      type Pressure = Real(unit = "Pa");
      type VolumeFlow = Real(unit = "m^3/s");
    end Units;

    package Interfaces
      import DSFLib.Hydraulics.Units.*;

      connector FluidPort
        Pressure p;
        flow VolumeFlow q;
        annotation(
          Icon(graphics = {Ellipse(origin = {0, 1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 99}, {100, -99}}, endAngle = 360)}));
      end FluidPort;

      partial model TwoPort
        FluidPort fluidPort_b annotation(
          Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        FluidPort fluidPort_a annotation(
          Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 98}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Pressure p;
        VolumeFlow q;
      equation
        p = fluidPort_b.p - fluidPort_a.p;
        q = fluidPort_b.q;
        q = -fluidPort_a.q;
        annotation(
          Icon);
      end TwoPort;
    end Interfaces;

    package Components
      import DSFLib.Hydraulics.Interfaces.*;
      import DSFLib.Hydraulics.Units.*;

      model Valve
        extends TwoPort;
        parameter Real RH(unit = "Pa.s/m^3") = 1000 "Hydraulic Resistance";
      equation
        p - RH * q = 0;
        annotation(
          Icon(graphics = {Line(origin = {1, -1}, rotation = -90, points = {{-81, 79}, {-81, -79}, {81, 83}, {81, -83}, {-79, 77}, {-81, 79}}), Text(origin = {118, -29}, rotation = -90, extent = {{-210, 7}, {152, -9}}, textString = "RH=%RH")}, coordinateSystem(initialScale = 0.1)));
      end Valve;

      model Tank
        parameter Real A(unit = "m^2") = 1 "Tank area";
        parameter Real g(unit = "m/s^2") = 9.8;
        parameter Real rho(unit = "Kg/m^3") = 1000 "Fluid density";
        FluidPort fluidPort annotation(
          Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -75}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        Real v(unit = "m^3");
        VolumeFlow q;
        Pressure p;
        Pressure dp;
      equation
        q = der(v);
        p = v * rho * g / A;
        dp = if v > 0 then 0 else 1e10 * q;
        fluidPort.q = q;
        fluidPort.p = p + dp;
        annotation(
          Diagram,
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(origin = {1, 10}, points = {{-81, 70}, {-81, -70}, {81, -70}, {81, 70}, {81, 70}}), Rectangle(origin = {1, -10}, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-79, 48}, {79, -48}}), Text(origin = {31, 98}, extent = {{-103, 10}, {49, -10}}, textString = "A=%A")}));
      end Tank;

      model Inertance
        extends TwoPort;
        parameter Real I(unit = "Pa.s^2/m^3") = 1;
      equation
        I * der(q) = p;
        annotation(
          Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-21, 83}, {21, -81}}), Text(origin = {73, 10}, rotation = -90, extent = {{-99, 8}, {115, -14}}, textString = "I=%I")}, coordinateSystem(initialScale = 0.1)));
      end Inertance;

      model Column
        extends TwoPort;
        parameter Real H(unit = "m") = 1 "Column height";
        parameter Real g(unit = "m/s^2") = 9.8;
        parameter Real rho(unit = "Kg/m^3") = 1000 "Fluid density";
      equation
        p = rho * g * H;
        annotation(
          Icon(graphics = {Rectangle(origin = {0, 1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-10, 81}, {10, -81}}), Text(origin = {73, 10}, rotation = -90, extent = {{-99, 8}, {115, -14}}, textString = "H=%H")}, coordinateSystem(initialScale = 0.1)));
      end Column;

      model ConstPress
        parameter Real P(unit = "Pa") = 0;
        FluidPort fluidPort annotation(
          Placement(visible = true, transformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {84, -8.88178e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
      equation
        fluidPort.p = P;
        annotation(
          Icon(graphics = {Polygon(origin = {13, -1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-33, 51}, {49, 1}, {-33, -43}, {-33, 49}, {-33, 51}}), Text(origin = {34, 81}, extent = {{-132, 13}, {84, -13}}, textString = "P=%P")}, coordinateSystem(initialScale = 0.1)));
      end ConstPress;

      model IdealPump
        extends TwoPort;
        parameter Real Q(unit = "m^3/s") = 1e-3;
      equation
        q = -Q;
        annotation(
          Icon(graphics = {Text(origin = {118, -29}, rotation = -90, extent = {{-210, 7}, {152, -9}}, textString = "Q=%Q"), Ellipse(origin = {1, 2}, extent = {{-101, 96}, {101, -96}}, endAngle = 360), Polygon(origin = {0, -40}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-22, 20}, {22, 20}, {0, -20}, {-22, 20}})}, coordinateSystem(initialScale = 0.1)));
      end IdealPump;
    end Components;

    package Examples
      import DSFLib.Hydraulics.Components.*;

      model TankValve
        Tank tank(v(start = 0.5)) annotation(
          Placement(visible = true, transformation(origin = {-48, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Valve valve(RH = 2e7)  annotation(
          Placement(visible = true, transformation(origin = {-14, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        ConstPress constPress annotation(
          Placement(visible = true, transformation(origin = {24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        Column column annotation(
          Placement(visible = true, transformation(origin = {-48, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        IdealPump idealPump(Q = 0.001) annotation(
          Placement(visible = true, transformation(origin = {-80, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        connect(constPress.fluidPort, valve.fluidPort_a) annotation(
          Line(points = {{16, -14}, {-4, -14}}));
        connect(tank.fluidPort, column.fluidPort_a) annotation(
          Line(points = {{-48, 24}, {-48, 14}}));
        connect(column.fluidPort_b, valve.fluidPort_b) annotation(
          Line(points = {{-48, -6}, {-48, -14}, {-24, -14}}));
        connect(idealPump.fluidPort_a, constPress.fluidPort) annotation(
          Line(points = {{-80, -2}, {-80, -2}, {-80, -44}, {16, -44}, {16, -14}, {16, -14}}));
        connect(idealPump.fluidPort_b, tank.fluidPort) annotation(
          Line(points = {{-80, 18}, {-80, 24}, {-48, 24}}));
      end TankValve;
    end Examples;
  end Hydraulics;

  package Thermal
    package Units
      type Temperature = Real(unit = "K", start = 293);
      type HeatFlow = Real(unit = "W");
    end Units;

    package Interfaces
      import DSFLib.Thermal.Units.*;

      connector HeatPort
        Temperature T;
        flow HeatFlow q;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
      end HeatPort;

      partial model TwoPort
        HeatPort heatPort_b annotation(
          Placement(visible = true, transformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, 8.88178e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        HeatPort heatPort_a annotation(
          Placement(visible = true, transformation(origin = {100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 8.88178e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Temperature T_rel;
        HeatFlow q;
      equation
        T_rel = heatPort_b.T - heatPort_a.T;
        q = heatPort_b.q;
        q = -heatPort_a.q;
      end TwoPort;
    end Interfaces;

    package Components
      import DSFLib.Thermal.Units.*;
      import DSFLib.Thermal.Interfaces.*;

      model HeatCapacitor
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -71}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter Real C(unit = "J/K") = 1 "Heat capacity";
        Temperature T;
        HeatFlow q;
      equation
        C * der(T) = q;
        q = heatPort.q;
        T = heatPort.T;
        annotation(
          Icon(graphics = {Rectangle(origin = {0, 10}, fillColor = {255, 0, 0}, fillPattern = FillPattern.VerticalCylinder, extent = {{-80, 70}, {80, -70}}), Text(origin = {11, 103}, extent = {{-151, 11}, {151, -11}}, textString = "C=%C")}));
      end HeatCapacitor;

      model ThermalResistor
        extends TwoPort;
        parameter Real R(unit = "K/W") = 1 "Heat resistance";
      equation
        R * q = T_rel;
        annotation(
          Icon(graphics = {Text(origin = {11, 103}, extent = {{-151, 11}, {151, -11}}, textString = "R=%R"), Rectangle(origin = {0, -3}, fillColor = {195, 163, 158}, fillPattern = FillPattern.Solid, extent = {{-88, 87}, {88, -87}}), Line(points = {{-84, 0}, {-70, 0}, {-60, -60}, {-42, 60}, {-20, -60}, {0, 60}, {20, -62}, {40, 62}, {60, -60}, {72, 0}, {84, 0}, {84, 0}}, color = {255, 0, 0})}));
      end ThermalResistor;

      model HeatFlowSource
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {97, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter HeatFlow Q = 1;
      equation
        heatPort.q = -Q;
        annotation(
          Icon(graphics = {Ellipse(origin = {0, -1}, lineColor = {255, 0, 0}, extent = {{-100, 99}, {100, -99}}), Line(points = {{-80, 0}, {80, 0}}, color = {255, 0, 0}), Polygon(origin = {60, -1}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-20, 21}, {20, 1}, {-20, -19}, {-20, 21}}), Text(origin = {1, 119}, extent = {{-123, 9}, {123, -9}}, textString = "q=%Q")}));
      end HeatFlowSource;

      model ConstTemp
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {97, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter Temperature T = 273.15;
      equation
        heatPort.T = T;
        annotation(
          Icon(graphics = {Rectangle(origin = {-18, -11}, fillColor = {255, 199, 197}, fillPattern = FillPattern.Forward, extent = {{-168, 97}, {98, -73}}), Text(origin = {-51, 113}, extent = {{-129, 13}, {159, -13}}, textString = "T=%T"), Text(origin = {-101, 1}, extent = {{-79, 23}, {183, -25}}, textString = "Tconst")}, coordinateSystem(initialScale = 0.1)));
      end ConstTemp;
    end Components;

    package Examples
      import DSFLib.Thermal.Components.*;

      model TwoCompartments
        HeatCapacitor room1 annotation(
          Placement(visible = true, transformation(origin = {-44, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        HeatCapacitor room2 annotation(
          Placement(visible = true, transformation(origin = {24, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermalResistor thermalResistor annotation(
          Placement(visible = true, transformation(origin = {-14, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        HeatFlowSource heatFlowSource annotation(
          Placement(visible = true, transformation(origin = {-72, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ThermalResistor thermalResistor1 annotation(
          Placement(visible = true, transformation(origin = {58, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        ConstTemp constTemp(T = 293) annotation(
          Placement(visible = true, transformation(origin = {92, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        connect(room1.heatPort, thermalResistor.heatPort_b) annotation(
          Line(points = {{-43.9, 22.9}, {-43.9, 16.9}, {-23.9, 16.9}}));
        connect(thermalResistor.heatPort_a, room2.heatPort) annotation(
          Line(points = {{-4.2, 16}, {23.8, 16}, {23.8, 23}}));
        connect(thermalResistor1.heatPort_b, room2.heatPort) annotation(
          Line(points = {{48.2, 16}, {24.2, 16}, {24.2, 22}}));
        connect(thermalResistor1.heatPort_a, constTemp.heatPort) annotation(
          Line(points = {{68, 16}, {82, 16}}));
        connect(heatFlowSource.heatPort, room1.heatPort) annotation(
          Line(points = {{-62, 16}, {-44, 16}, {-44, 22}}));
      end TwoCompartments;
    end Examples;
  end Thermal;

  package MultiDomain
    package ElectroMechanical
      package Components
        import DSFLib.Circuits.Interfaces.*;
        import DSFLib.Circuits.Units.*;
        import DSFLib.Mechanical.Rotational.Interfaces.*;
        import DSFLib.Mechanical.Rotational.Units.*;

        model EMF
          Pin p annotation(
            Placement(visible = true, transformation(origin = {-76, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-10, 102}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          Pin n annotation(
            Placement(visible = true, transformation(origin = {-74, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-14, -92}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          Flange flange annotation(
            Placement(visible = true, transformation(origin = {98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {131, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          Voltage e;
          Current i;
          Torque tau;
          Real w(unit = "rad/s");
          parameter Real K(unit = "V.s/rad") = 1;
        equation
          e = p.v - n.v;
          p.i = i;
          n.i + p.i = 0;
          e = K * w;
          tau = K * i;
          tau = -flange.tau;
          w = der(flange.phi);
          annotation(
            Icon(graphics = {Ellipse(origin = {-13, 5}, extent = {{-85, 83}, {85, -83}}), Rectangle(origin = {54, 1}, fillColor = {240, 240, 240}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-66, 7}, {66, -7}})}));
        end EMF;

        model SepExcDCM
          DSFLib.Circuits.Components.NLInductor inductor(currTable = currTable, fluxTable = fluxTable) annotation(
            Placement(visible = true, transformation(origin = {-46, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p_ex annotation(
            Placement(visible = true, transformation(origin = {-98, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-188, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n_ex annotation(
            Placement(visible = true, transformation(origin = {-98, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-189, -95}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {2, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {95, 99}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {2, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {105, -99}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {236, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          parameter Real[:] currTable = {-2, -1, 0, 1, 2};
          parameter Real[:] fluxTable = {-2, -1, 0, 1, 2};
          Voltage e;
          Current i;
          Torque tau;
          Real w(unit = "rad/s");
          parameter Real K(unit = "1/rad") = 1;
        equation
          e = p.v - n.v;
          p.i = i;
          n.i + p.i = 0;
          e = K * inductor.phi * w;
          tau = K * inductor.phi * i;
          tau = -flange.tau;
          w = der(flange.phi);
          connect(p_ex, inductor.p) annotation(
            Line(points = {{-98, 38}, {-56, 38}, {-56, 36}}));
          connect(inductor.n, n_ex) annotation(
            Line(points = {{-36, 36}, {-16, 36}, {-16, -48}, {-98, -48}}));
          annotation(
            Icon(graphics = {Rectangle(origin = {166, -5}, fillColor = {240, 240, 240}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-66, 7}, {66, -7}}), Ellipse(origin = {99, -1}, extent = {{-85, 83}, {85, -83}}), Line(origin = {-50.2557, -10.2841}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {9.85795, -10.4261}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-20.4262, -10.2841}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-80.5398, -10.142}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-160.108, 20}, points = {{-20, 30}, {4, 30}, {4, -30}, {20, -30}}), Line(origin = {-99.5114, -78.1136}, points = {{80, 66}, {80, -20}, {-78, -20}, {-78, -20}}), Line(origin = {-78.9148, 29.4034}, points = {{-50, 0}, {50, 0}}), Line(origin = {-78.9148, 40.142}, points = {{-50, 0}, {50, 0}})}));
        end SepExcDCM;
      end Components;

      package Examples
        model DCMotor
          DSFLib.MultiDomain.ElectroMechanical.Components.EMF emf annotation(
            Placement(visible = true, transformation(origin = {-6, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-42, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
            Placement(visible = true, transformation(origin = {28, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor resistor annotation(
            Placement(visible = true, transformation(origin = {-54, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt constVolt annotation(
            Placement(visible = true, transformation(origin = {-76, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Inductor inductor annotation(
            Placement(visible = true, transformation(origin = {-24, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(emf.n, ground.p) annotation(
            Line(points = {{-7, 19}, {-8, 19}, {-8, -4}, {-42, -4}}));
          connect(emf.flange, inertia.flange) annotation(
            Line(points = {{7, 28}, {18, 28}}));
          connect(constVolt.p, resistor.p) annotation(
            Line(points = {{-75.8, 37.8}, {-75.8, 58}, {-64, 58}}));
          connect(constVolt.n, ground.p) annotation(
            Line(points = {{-76, 18}, {-76, -4}, {-42, -4}}));
          connect(resistor.n, inductor.p) annotation(
            Line(points = {{-44, 58}, {-34, 58}}));
          connect(inductor.n, emf.p) annotation(
            Line(points = {{-14, 58}, {-7, 58}, {-7, 38}}));
        end DCMotor;

        model DCMotorSepExc
          DSFLib.Circuits.Components.ConstVolt constVolt annotation(
            Placement(visible = true, transformation(origin = {-54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Resistor resistor annotation(
            Placement(visible = true, transformation(origin = {-22, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {12, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.ElectroMechanical.Components.SepExcDCM sepExcDCM annotation(
            Placement(visible = true, transformation(origin = {36, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Inductor inductor annotation(
            Placement(visible = true, transformation(origin = {16, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor resistor1 annotation(
            Placement(visible = true, transformation(origin = {-8, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mechanical.Rotational.Components.Inertia inertia annotation(
            Placement(visible = true, transformation(origin = {86, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(constVolt.p, resistor.p) annotation(
            Line(points = {{-54, 10}, {-54, 48}, {-32, 48}}));
          connect(constVolt.n, ground.p) annotation(
            Line(points = {{-54, -10}, {-54, -30}, {12, -30}}));
          connect(sepExcDCM.n, ground.p) annotation(
            Line(points = {{46, 6}, {46, -30}, {12, -30}}));
          connect(resistor.n, inductor.p) annotation(
            Line(points = {{-12, 48}, {6, 48}}));
          connect(inductor.n, sepExcDCM.p) annotation(
            Line(points = {{26, 48}, {46, 48}, {46, 26}}));
          connect(resistor1.n, sepExcDCM.p_ex) annotation(
            Line(points = {{2, 22}, {18, 22}}));
          connect(resistor1.p, constVolt.p) annotation(
            Line(points = {{-18, 22}, {-54, 22}, {-54, 10}}));
          connect(sepExcDCM.flange, inertia.flange) annotation(
            Line(points = {{60, 16}, {76, 16}}));
          connect(sepExcDCM.n_ex, ground.p) annotation(
            Line(points = {{18, 6}, {12, 6}, {12, -30}}));
        end DCMotorSepExc;
      end Examples;
    end ElectroMechanical;

    package HydroMechanical
      package Components
        import DSFLib.Hydraulics.Units.*;
        import DSFLib.Hydraulics.Interfaces.*;
        import DSFLib.Mechanical.Translational.Units.*;
        import DSFLib.Mechanical.Translational.Interfaces.*;

        model PistonCylinder
          extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
          DSFLib.Hydraulics.Interfaces.FluidPort fluidPort annotation(
            Placement(visible = true, transformation(origin = {36, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-39, -97}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real A(unit = "m^2") = 1;
        equation
          fluidPort.q = der(s_rel) * A;
          fluidPort.p * A = -f;
          annotation(
            Icon(graphics = {Line(origin = {49.6136, -0.596591}, rotation = 180, points = {{-33, 6}, {13, 6}, {13, 60}, {33, 60}, {33, -60}, {13, -60}, {13, -6}, {-33, -6}}), Line(origin = {33.0284, -51.6136}, rotation = 180, points = {{-68, -29}, {-48, -29}, {-48, 13}, {68, 13}, {68, 29}}), Line(origin = {1.19318, -8.10794}, rotation = 180, points = {{-100, -30}, {-80, -30}, {-80, -72}, {100, -72}, {100, 56}, {44, 56}, {44, 72}}), Text(origin = {-5, 87}, extent = {{-151, -15}, {151, 15}}, textString = "A=%A")}));
        end PistonCylinder;
      end Components;

      package Examples
        model HydraulicJack
          DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder annotation(
            Placement(visible = true, transformation(origin = {-42, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder1(A = 10) annotation(
            Placement(visible = true, transformation(origin = {38, 8}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Hydraulics.Components.Valve valve(RH = 100) annotation(
            Placement(visible = true, transformation(origin = {-2, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-14, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -1) annotation(
            Placement(visible = true, transformation(origin = {-70, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Translational.Components.Mass mass annotation(
            Placement(visible = true, transformation(origin = {38, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.ConstForce constForce1(F = -9.8) annotation(
            Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(valve.fluidPort_a, pistonCylinder1.fluidPort) annotation(
            Line(points = {{8, 4}, {28, 4}}));
          connect(mass.flange, constForce1.flange) annotation(
            Line(points = {{38, 40}, {70, 40}}));
          connect(pistonCylinder.fluidPort, valve.fluidPort_b) annotation(
            Line(points = {{-32, 4}, {-12, 4}}));
          connect(mass.flange, pistonCylinder1.flange_b) annotation(
            Line(points = {{38, 40}, {38, 18}}));
          connect(pistonCylinder1.flange_a, fixed.flange) annotation(
            Line(points = {{38, -2}, {38, -26}, {-14, -26}}));
          connect(pistonCylinder.flange_a, fixed.flange) annotation(
            Line(points = {{-42, -2}, {-42, -26}, {-14, -26}}));
          connect(constForce.flange, pistonCylinder.flange_b) annotation(
            Line(points = {{-70, 36}, {-42, 36}, {-42, 18}}));
        end HydraulicJack;
      end Examples;
    end HydroMechanical;

    package HydroThermal
      package Components
        import DSFLib.Thermal.Units.*;
        import DSFLib.Thermal.Interfaces.*;
        import DSFLib.Hydraulics.Units.*;
        import DSFLib.Hydraulics.Interfaces.*;

        model Convection
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          HeatPort heatPort_a annotation(
            Placement(visible = true, transformation(origin = {68, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {72, 98}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          HeatPort heatPort_b annotation(
            Placement(visible = true, transformation(origin = {68, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {73, -97}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Temperature T;
          HeatFlow q_heat;
          parameter Real rho(unit = "Kg/m^3") = 1000 "Fluid density";
          parameter Real c(unit = "J/K/Kg") = 4184 "Fluid specific heat capacity";
        equation
          p = 0;
          q_heat = heatPort_b.q;
          q_heat = -heatPort_a.q;
          T = heatPort_b.T;
          q_heat = rho * c * q * T;
          annotation(
            Icon(graphics = {Rectangle(origin = {15, -3}, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-47, 85}, {85, -81}}), Polygon(origin = {0, 70}, lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{0, 10}, {16, -12}, {-14, -12}, {0, 10}}), Rectangle(origin = {2, -9}, lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-6, 69}, {2, -69}}), Polygon(origin = {72, 68}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{0, 10}, {12, -10}, {-12, -10}, {0, 10}}), Rectangle(origin = {74, -11}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-6, 69}, {2, -69}})}, coordinateSystem(initialScale = 0.1)));
        end Convection;
      end Components;

      package Examples
        model SolarCollector
          DSFLib.Thermal.Components.HeatCapacitor heatCapacitor annotation(
            Placement(visible = true, transformation(origin = {-14, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          DSFLib.Thermal.Components.HeatCapacitor heatCapacitor1 annotation(
            Placement(visible = true, transformation(origin = {-14, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Thermal.Components.ThermalResistor thermalResistor annotation(
            Placement(visible = true, transformation(origin = {-14, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.HeatFlowSource heatFlowSource annotation(
            Placement(visible = true, transformation(origin = {12, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.ConstTemp constTemp(T = 293) annotation(
            Placement(visible = true, transformation(origin = {-92, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection annotation(
            Placement(visible = true, transformation(origin = {-44, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
          DSFLib.Hydraulics.Components.IdealPump idealPump annotation(
            Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.ConstPress constPress annotation(
            Placement(visible = true, transformation(origin = {-94, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection1 annotation(
            Placement(visible = true, transformation(origin = {14, -10}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.ThermalResistor thermalResistor1 annotation(
            Placement(visible = true, transformation(origin = {-46, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Thermal.Components.ConstTemp constTemp1(T = 293) annotation(
            Placement(visible = true, transformation(origin = {56, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        equation
          connect(constPress.fluidPort, idealPump.fluidPort_a) annotation(
            Line(points = {{-86, -46}, {-78, -46}, {-78, -30}, {-78, -30}}));
          connect(idealPump.fluidPort_b, convection.fluidPort_b) annotation(
            Line(points = {{-78, -10}, {-54, -10}}));
          connect(constTemp.heatPort, convection.heatPort_b) annotation(
            Line(points = {{-82, 12}, {-54, 12}, {-54, -2}, {-54, -2}}));
          connect(convection.heatPort_a, heatCapacitor.heatPort) annotation(
            Line(points = {{-34, -2}, {-14, -2}, {-14, -3}}));
          connect(convection1.fluidPort_a, constPress.fluidPort) annotation(
            Line(points = {{24, -10}, {24, -46}, {-86, -46}}));
          connect(thermalResistor.heatPort_a, heatCapacitor.heatPort) annotation(
            Line(points = {{-14, 4}, {-14, -3}}));
          connect(thermalResistor.heatPort_b, heatCapacitor1.heatPort) annotation(
            Line(points = {{-14, 24}, {-14, 31}}));
          connect(thermalResistor1.heatPort_a, constTemp.heatPort) annotation(
            Line(points = {{-56, 30}, {-82, 30}, {-82, 12}}));
          connect(heatFlowSource.heatPort, heatCapacitor1.heatPort) annotation(
            Line(points = {{12, 42}, {12, 31}, {-14, 31}}));
          connect(convection1.heatPort_a, constTemp1.heatPort) annotation(
            Line(points = {{24, -3}, {46, -3}, {46, 12}}));
          connect(convection.fluidPort_a, convection1.fluidPort_b) annotation(
            Line(points = {{-34, -10}, {-28, -10}, {-28, -26}, {-4, -26}, {-4, -10}, {4, -10}, {4, -10}}));
          connect(thermalResistor1.heatPort_b, heatCapacitor1.heatPort) annotation(
            Line(points = {{-36, 30}, {-14, 30}, {-14, 30}, {-14, 30}}));
          connect(heatCapacitor.heatPort, convection1.heatPort_b) annotation(
            Line(points = {{-14, -2}, {4, -2}, {4, -2}, {4, -2}}));
        end SolarCollector;
      end Examples;
    end HydroThermal;

    package ElectroThermal
      import DSFLib.Circuits.Components;
      import DSFLib.Thermal.Interfaces;

      package Components
        model HeatingResistor
          extends DSFLib.Circuits.Components.Resistor;
          DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
            Placement(visible = true, transformation(origin = {0, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -147}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
        equation
          heatPort.q = -v * i;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {4, -45}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-6, 13}, {2, -69}}), Polygon(origin = {2, -122}, rotation = 180, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{0, 10}, {12, -10}, {-12, -10}, {0, 10}})}));
        end HeatingResistor;
      end Components;

      package Examples
        model WaterHeater
          DSFLib.MultiDomain.ElectroThermal.Components.HeatingResistor heatingResistor annotation(
            Placement(visible = true, transformation(origin = {-20, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-16, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt constVolt annotation(
            Placement(visible = true, transformation(origin = {-50, -36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.HeatCapacitor heatCapacitor annotation(
            Placement(visible = true, transformation(origin = {26, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Thermal.Components.ConstTemp constTemp(T = 293) annotation(
            Placement(visible = true, transformation(origin = {-60, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection annotation(
            Placement(visible = true, transformation(origin = {6, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection1 annotation(
            Placement(visible = true, transformation(origin = {42, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.ConstTemp constTemp1(T = 293) annotation(
            Placement(visible = true, transformation(origin = {88, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.IdealPump idealPump annotation(
            Placement(visible = true, transformation(origin = {-32, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Hydraulics.Components.ConstPress constPress annotation(
            Placement(visible = true, transformation(origin = {22, 64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(constVolt.n, ground.p) annotation(
            Line(points = {{-50, -46}, {-50, -52}, {-16, -52}}));
          connect(constVolt.p, heatingResistor.n) annotation(
            Line(points = {{-50, -26}, {-50, -16}, {-30, -16}}));
          connect(heatingResistor.p, ground.p) annotation(
            Line(points = {{-10, -16}, {0, -16}, {0, -52}, {-16, -52}, {-16, -52}}));
          connect(convection.heatPort_a, convection1.heatPort_b) annotation(
            Line(points = {{16, 7}, {32, 7}}));
          connect(heatCapacitor.heatPort, convection1.heatPort_b) annotation(
            Line(points = {{26, -3}, {26, 7}, {32, 7}}));
          connect(heatingResistor.heatPort, heatCapacitor.heatPort) annotation(
            Line(points = {{-20, -2}, {26, -2}, {26, -2}, {26, -2}}));
          connect(constPress.fluidPort, idealPump.fluidPort_a) annotation(
            Line(points = {{22, 56}, {-32, 56}, {-32, 52}, {-32, 52}}));
          connect(idealPump.fluidPort_b, convection.fluidPort_b) annotation(
            Line(points = {{-32, 32}, {-32, 14}, {-4, 14}}));
          connect(convection.fluidPort_a, convection1.fluidPort_b) annotation(
            Line(points = {{16, 14}, {32, 14}}));
          connect(convection1.fluidPort_a, constPress.fluidPort) annotation(
            Line(points = {{52, 14}, {60, 14}, {60, 56}, {22, 56}}));
          connect(convection1.heatPort_a, constTemp1.heatPort) annotation(
            Line(points = {{52, 6}, {78, 6}, {78, 6}, {78, 6}}));
          connect(constTemp.heatPort, convection.heatPort_b) annotation(
            Line(points = {{-50, 6}, {-4, 6}, {-4, 6}, {-4, 6}}));
        end WaterHeater;
      end Examples;
    end ElectroThermal;
  end MultiDomain;

  package ControlSystems
    package Blocks
      package Interfaces
        connector RealInput = input Real annotation(
          Icon(graphics = {Polygon(fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}));
        connector RealOutput = output Real annotation(
          Icon(graphics = {Polygon(fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}));

        partial block SISO
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {-112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-117, 1}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {112, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {118, 1.77636e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          annotation(
            Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}));
        end SISO;
      end Interfaces;

      package Components
        block Integrator
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO(y.start = y_0);
          parameter Real y_0 = 0;
        equation
          der(y) = u;
          annotation(
            Icon(graphics = {Bitmap(origin = {-2, 2}, extent = {{90, 82}, {-90, -82}}, imageSource = "iVBORw0KGgoAAAANSUhEUgAAAC4AAABcCAYAAAARU4f9AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAuIwAALiMBeKU/dgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAQCSURBVHic7ZtLbE1BGMd/+qDe9agq9Wix8IgEQSQshB2xQCKxsbXASiI2EqzsEJFILHQhNixYEalIhISIRNBoqVSjGvEoFbSathZzj557zszc05xvzp0m95+cRb+Z+ebX737nzJk5M1B81QHHgGbgEzAA9ALtwA3gEDCraHQajQdOA7+B4dz1E3gNtAJ9IXsfcAaYUhTSkGYBjxgB6wB2AhWhOuXABuAs0J+r9xyYlyVoWFXkQ7/DngqVwAlgKFf/KerXylxXGYEeArZY6k4DHobqB9dhx4wx7Y0ANBeof4Y49DDwxCFjTJOBzgjA7gJtWtCD97rDjOtopPPfwIQCbdrQg391h5mvCuB9pPO7CdqdRw/e5AYzrj2azo8naDcduBNpdx+Y7YRSo+vEwbePov1aYB+wTh7NrKnkj47BVbSBJKl2EYfuSeu0LK2DBNqqsbWkdZoF+GaNrSOtU9fgZcByjb1LwrFLNaBGzKi60zp2Db7KYPcefKXB/jGtY9fgKwz2z2kdFyviXxz3m1o/iQ8+g6hpmbeqxeErqctUWWKwi6SJS/BGg70UcVdqMNjHbMS9Bx+TOT4RtZipk9c53giMM5R5HfHFljKvwRdZyrxOlQWWMq/BFxrsIjN8yD7ivcBfiQ6yjrjYYqUL8HLMq1RiEwgX4HWozx86eR1x2xPFa3DbMzz17D6QC3DTjQkC6ymBXIDXW8q8jrjprRAE1gwDuQCvtZR5HXET+DCCOe5C39Gvp6RedgtLOuJVqC9lOomlCciD11jKRNNEGnyupaxTsiNpcNsTxWvwOZYyr8FtOT5mwTskO5IGN21RGkRwuAd5cNOuhm7UtjwxZRXx98L9ZBZx0RsTShEH1Oy+2lDmdcRnWPx5HXHbPql2wX6AbMCHEB58QBbcdGN2oTb1iiqLiIunCWQT8XeCffxXCZxSqiRTKeLATI3tB462TEuC62Y/rYL+8yQFXoZ6V4nqlZB/bYcSqkW/z8p7cNNi/ksh/zFJgZu++4zJiPciPLMPyyX4M9TyshNJga/W2G4L+Xaqz8QX8nX/jFeaTxy6FfMOIREFxxArUYcwluU6vYVaNkui9RpbEw7zO1A98IL4Ibikhz4vRdoOYP/WKaZr6D82nUvYPnrw7oo8ol496MGTvCBtJB7tpW4w81WGeS93ktXVI5G/LwJvUxGNQo/RR/xUgXYNqG1KQf02YJI7zLgOEoe+WQCiHHgQqv8LlTaZqoKRw8/9wIEC9SuBy4xA/2F0JwVFVYN6BA6jzsBfADaRv0WpHNhB/uHnD+jPsmWqKuAk6mcPwPqBN7krfMB/EDXI6GY9mUg3LFcD+4FtwBrUt8tK4BvqVOA91LPfybJDUv0D7tQsfW31v+gAAAAASUVORK5CYII=")}));
        end Integrator;

        block StateSpace
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real A[:, size(A, 1)] = [0, 1; -1, -1];
          parameter Real B[size(A, 1), 1] = [0; 1];
          parameter Real C[1, size(A, 1)] = [1, 0];
          parameter Real D[1, 1] = [0];
          parameter Real x_0[size(A, 1), 1] = [0; 0];
          Real x[size(A, 1), 1](start = x_0);
        protected
          Real ymat[1, 1];
        equation
          der(x) = A * x + B * u;
          ymat = C * x + D * u;
          y = ymat[1, 1];
          annotation(
            Icon(graphics = {Text(origin = {-2, 44}, extent = {{-90, 22}, {90, -22}}, textString = "x=Ax+Bu"), Text(origin = {-59, 61}, extent = {{-19, 17}, {19, -17}}, textString = ".", textStyle = {TextStyle.Bold}), Text(origin = {0, -30}, extent = {{-90, 22}, {90, -22}}, textString = "y=Cx+Du")}));
        end StateSpace;

        block StepSource
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {116, -8.88178e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          parameter Real U = 1 "Step amplitude";
          parameter Real Tstep = 0;
        equation
          y = if time < Tstep then 0 else U;
          annotation(
            Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Line(origin = {0, 40}, points = {{-100, -100}, {0, -100}, {0, 40}, {100, 40}}), Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U")}));
        end StepSource;

        block Add
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u1 annotation(
            Placement(visible = true, transformation(origin = {-110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-117, 59}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u2 annotation(
            Placement(visible = true, transformation(origin = {-112, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-118, -60}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Real k1 = 1 "Gain on first input";
          parameter Real k2 = 1 "Gain on second input";
        equation
          y = k1 * u1 + k2 * u2;
          annotation(
            Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-63, 58}, extent = {{-29, 22}, {29, -22}}, textString = "%k1"), Text(origin = {-63, -58}, extent = {{-29, 22}, {29, -22}}, textString = "%k2"), Line(origin = {19.0908, -8.66977e-08}, points = {{0, 40}, {0, -40}}, thickness = 0.5), Line(origin = {19.6908, -8.66977e-08}, points = {{-40, 0}, {40, 0}}, thickness = 0.5)}));
        end Add;

        block TransferFunction
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real num[:] = {1} "Numerator coefficients";
          parameter Real den[:] = {1, 1} "Denominator coefficients";
        protected
          parameter Real A[size(den, 1) - 1, size(den, 1) - 1](each fixed = false);
          parameter Real B[size(den, 1) - 1, 1](each fixed = false);
          parameter Real C[1, size(den, 1) - 1](each fixed = false);
          parameter Real D[1, 1](each fixed = false);
          Real x[size(den, 1) - 1, 1];
          Real ymat[1, 1];
        initial algorithm
          (A, B, C, D) := DSFLib.Utilities.Functions.TF2SS(num, den);
        equation
          der(x) = A * x + B * u;
          ymat = C * x + D * u;
          y = ymat[1, 1];
          annotation(
            Icon(graphics = {Text(origin = {7, 1}, extent = {{-65, 57}, {65, -57}}, textString = "H(s)")}));
        end TransferFunction;

        block Gain
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real K = 1 "Gain";
        equation
          y = K * u;
          annotation(
            Icon(graphics = {Text(origin = {-5, 3}, extent = {{-89, 39}, {89, -39}}, textString = "K=%K")}));
        end Gain;

        block DiscreteStateSpace
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real A[:, size(A, 1)] = [0.5, 0.5; -0.5, 0.5];
          parameter Real B[size(A, 1), 1] = [0; 1];
          parameter Real C[1, size(A, 1)] = [1, 0];
          parameter Real D[1, 1] = [0];
          parameter Real x_0[size(A, 1), 1] = [0; 0];
          parameter Real T = 0.1 "Sample Period";
          discrete Real x[size(A, 1), 1](start = x_0);
        protected
          discrete Real ymat[1, 1];
        equation
          y = ymat[1, 1];
        algorithm
          when sample(0, T) then
            ymat := C * x + D * u;
            x := A * x + B * u;
          end when;
          annotation(
            Icon(graphics = {Text(origin = {-2, 44}, extent = {{-90, 22}, {90, -22}}, textString = "x⁺=Ax+Bu"), Text(origin = {0, -30}, extent = {{-90, 22}, {90, -22}}, textString = "y=Cx+Du")}));
        end DiscreteStateSpace;

        block DiscreteTransferFunction
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real num[:] = {1, -0.95} "Numerator coefficients";
          parameter Real den[:] = {1, -1} "Denominator coefficients";
          parameter Real T = 0.1 "Sample Period";
        protected
          parameter Integer n = size(den, 1);
          parameter Integer m = size(num, 1);
          discrete Real ylast[n](each start = 0);
          discrete Real ulast[n](each start = 0);
        equation
          y = ylast[1];
        algorithm
          when sample(0, T) then
            ylast[2:n] := ylast[1:n - 1];
            ulast[2:n] := ulast[1:n - 1];
            ulast[1] := u;
            ylast[1] := (-ylast[2:n] * den[2:n] / den[1]) + ulast[n - m + 1:n] * num[1:m] / den[1];
          end when;
          annotation(
            Icon(graphics = {Text(origin = {7, 1}, extent = {{-65, 57}, {65, -57}}, textString = "H(z)")}));
        end DiscreteTransferFunction;
      end Components;

      package Examples
        model ControlSystem1
          DSFLib.ControlSystems.Blocks.Components.StepSource stepSource annotation(
            Placement(visible = true, transformation(origin = {-78, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.StateSpace stateSpace annotation(
            Placement(visible = true, transformation(origin = {72, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.TransferFunction transferFunction(den = {1, 10}, num = {10}) annotation(
            Placement(visible = true, transformation(origin = {36, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.ControlSystems.Blocks.Components.Integrator integrator annotation(
            Placement(visible = true, transformation(origin = {0, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add1(k1 = 1, k2 = 1) annotation(
            Placement(visible = true, transformation(origin = {36, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add(k1 = 1, k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {-38, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gain gain(K = 1.2) annotation(
            Placement(visible = true, transformation(origin = {-4, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(stateSpace.y, transferFunction.u) annotation(
            Line(points = {{84, 8}, {94, 8}, {94, -28}, {48, -28}}));
          connect(add1.y, stateSpace.u) annotation(
            Line(points = {{48, 8}, {60, 8}}));
          connect(integrator.y, add1.u2) annotation(
            Line(points = {{12, -8}, {17, -8}, {17, 2}, {24, 2}}));
          connect(add.y, integrator.u) annotation(
            Line(points = {{-26, 2}, {-20, 2}, {-20, -8}, {-12, -8}}));
          connect(stepSource.y, add.u1) annotation(
            Line(points = {{-66, 8}, {-50, 8}}));
          connect(transferFunction.y, add.u2) annotation(
            Line(points = {{24, -28}, {-62, -28}, {-62, -4}, {-50, -4}}));
          connect(gain.y, add1.u1) annotation(
            Line(points = {{8, 20}, {14, 20}, {14, 14}, {24, 14}}));
          connect(gain.u, add.y) annotation(
            Line(points = {{-16, 20}, {-20, 20}, {-20, 2}, {-26, 2}}));
        protected
        end ControlSystem1;

        model DiscreteControlSystem
          DSFLib.ControlSystems.Blocks.Components.StepSource stepSource annotation(
            Placement(visible = true, transformation(origin = {-62, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.DiscreteTransferFunction discreteTransferFunction(den = {1, -1}, num = {1, -0.95}) annotation(
            Placement(visible = true, transformation(origin = {28, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.StateSpace stateSpace annotation(
            Placement(visible = true, transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(stepSource.y, add.u1) annotation(
            Line(points = {{-50, 14}, {-26, 14}}));
          connect(add.y, discreteTransferFunction.u) annotation(
            Line(points = {{-2, 8}, {16, 8}}));
          connect(discreteTransferFunction.y, stateSpace.u) annotation(
            Line(points = {{40, 8}, {58, 8}}));
          connect(stateSpace.y, add.u2) annotation(
            Line(points = {{82, 8}, {90, 8}, {90, -18}, {-32, -18}, {-32, 2}, {-26, 2}}));
        protected
        end DiscreteControlSystem;
      end Examples;
    end Blocks;

    package Sensors
      package Circuits
        model VoltageSensor
          extends DSFLib.Circuits.Interfaces.OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = v;
          i = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {-2, -60}, extent = {{-42, 52}, {42, -52}}, textString = "V"), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}}), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}})}));
        end VoltageSensor;

        model CurrentSensor
          extends DSFLib.Circuits.Interfaces.OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = i;
          v = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {0, -54}, extent = {{-42, 52}, {42, -52}}, textString = "I"), Polygon(origin = {58, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-2.24432, -19.4034}, points = {{-70, 0}, {70, 0}})}));
        end CurrentSensor;
      end Circuits;

      package Mechanical
        package Translational
          model ForceSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = f;
            s_rel = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {0, -48}, extent = {{-42, 52}, {42, -52}}, textString = "F")}));
          end ForceSensor;

          model DistanceSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = s_rel;
            f = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {0, -59}, extent = {{-56, 77}, {56, -77}}, textString = "s_rel"), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}})}));
          end DistanceSensor;

          model SpeedSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = der(s_rel);
            f = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {4, -65}, extent = {{-56, 77}, {56, -77}}, textString = "v_rel"), Polygon(origin = {58, -22}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-1.05114, -21.1932}, points = {{-70, 0}, {70, 0}})}));
          end SpeedSensor;
        end Translational;

        package Rotational
          model TorqueSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = tau;
            phi_rel = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {120, 120, 120}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {3, -38}, extent = {{-45, 66}, {45, -66}}, textString = "𝜏")}));
          end TorqueSensor;

          model AngleSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = phi_rel;
            tau = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {120, 120, 120}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {1, -43}, extent = {{-37, 53}, {37, -53}}, textString = "ϕ"), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}})}));
          end AngleSensor;

          model AngSpeedSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = der(phi_rel);
            tau = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {120, 120, 120}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {9, -56}, extent = {{-47, 58}, {47, -58}}, textString = "ω"), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}})}));
          end AngSpeedSensor;
        end Rotational;

        package Planar
          model ForceSensor
            extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = f;
            l = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {0, -48}, extent = {{-42, 52}, {42, -52}}, textString = "F")}));
          end ForceSensor;

          model DistanceSensor
            extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = l;
            f = 0;
            annotation(
              Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {170, 85, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {11, -57}, extent = {{-35, 49}, {35, -49}}, textString = "L"), Polygon(origin = {62, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {1.33523, -20.5966}, points = {{-70, 0}, {70, 0}})}));
          end DistanceSensor;
        end Planar;
      end Mechanical;

      package Hydraulics
        model PressureSensor
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {118, -2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        equation
          y = p;
          q = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {1, -50}, extent = {{-41, 50}, {41, -50}}, textString = "P")}));
        end PressureSensor;

        model FlowSensor
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {118, -2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        equation
          y = q;
          p = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {-2, -41}, extent = {{-40, 45}, {40, -45}}, textString = "Q")}));
        end FlowSensor;
      end Hydraulics;

      package Thermal
        model TemperatureSensor
          extends DSFLib.Thermal.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = T_rel;
          q = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {3, -53}, extent = {{-39, 47}, {39, -47}}, textString = "T"), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}})}));
        end TemperatureSensor;

        model HeatFlowSensor
          extends DSFLib.Thermal.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = q;
          T_rel = 0;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {24, 39}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-28, -37}, {28, 45}, {-18, -45}, {-18, -45}, {-28, -37}}), Line(origin = {-70, 50}, points = {{-10, 10}, {10, -10}}), Line(origin = {0, 90}, points = {{0, 10}, {0, -10}}), Line(origin = {70, 50}, points = {{10, 10}, {-10, -10}}), Text(origin = {-2, -40}, extent = {{-42, 52}, {42, -52}}, textString = "q"), Polygon(origin = {50, -20}, fillPattern = FillPattern.Solid, points = {{10, 0}, {-10, 20}, {-10, -20}, {10, 0}}), Line(origin = {-10, -20}, points = {{-70, 0}, {70, 0}})}));
        end HeatFlowSensor;
      end Thermal;
    end Sensors;

    package Actuators
      package Circuits
        import DSFLib.Circuits.Interfaces.*;
        model ControlledCurrent
  extends OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -112}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
        equation
          i = -u;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-78, 80}, {82, -78}}), Line(origin = {-0.117647, 0}, points = {{-50, 0}, {50, 0}, {50, 0}}), Line(origin = {-81, 0}, points = {{-3, 0}, {3, 0}, {3, 0}}), Line(origin = {84, 0}, points = {{-2, 0}, {2, 0}, {2, 0}}), Line(origin = {-35.6, -1.00112}, points = {{15.6, 25.0011}, {-16.4, 1.00112}, {15.6, -22.9989}, {15.6, -22.9989}})}));
        end ControlledCurrent;
      
        model ControlledVoltage
  extends OnePort;
          Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -112}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
        equation
          v = u;
          annotation(
            Icon(graphics = {Ellipse(extent = {{-78, 80}, {82, -78}}), Line(origin = {-81, 0}, points = {{-3, 0}, {3, 0}, {3, 0}}), Line(origin = {84, 0}, points = {{-2, 0}, {2, 0}, {2, 0}}), Line(origin = {-40.2102, -1.19318}, points = {{0, 20}, {0, -20}}), Line(origin = {-40, 0}, points = {{-20, 0}, {20, 0}}), Line(origin = {40.9091, -1.14205}, points = {{0, 21}, {0, -17}})}));
        end ControlledVoltage;
      

      end Circuits;
    end Actuators;

    package Examples
      model ControlledDCMotor
        DSFLib.Circuits.Components.Resistor resistor annotation(
          Placement(visible = true, transformation(origin = {-22, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Circuits.Components.Ground ground annotation(
          Placement(visible = true, transformation(origin = {12, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.MultiDomain.ElectroMechanical.Components.SepExcDCM sepExcDCM annotation(
          Placement(visible = true, transformation(origin = {36, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Circuits.Components.Inductor inductor annotation(
          Placement(visible = true, transformation(origin = {16, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Circuits.Components.Resistor resistor1 annotation(
          Placement(visible = true, transformation(origin = {-8, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
          Placement(visible = true, transformation(origin = {86, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
          Placement(visible = true, transformation(origin = {22, -64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        DSFLib.ControlSystems.Sensors.Mechanical.Rotational.AngSpeedSensor angSpeedSensor annotation(
          Placement(visible = true, transformation(origin = {62, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Actuators.Circuits.ControlledVoltage controlledVoltage annotation(
          Placement(visible = true, transformation(origin = {-44, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1)  annotation(
          Placement(visible = true, transformation(origin = {-124, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Blocks.Components.StepSource stepSource annotation(
          Placement(visible = true, transformation(origin = {-164, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 2)  annotation(
          Placement(visible = true, transformation(origin = {-84, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(sepExcDCM.n, ground.p) annotation(
          Line(points = {{46, 6}, {46, -30}, {12, -30}}));
        connect(resistor.n, inductor.p) annotation(
          Line(points = {{-12, 48}, {6, 48}}));
        connect(inductor.n, sepExcDCM.p) annotation(
          Line(points = {{26, 48}, {46, 48}, {46, 26}}));
        connect(resistor1.n, sepExcDCM.p_ex) annotation(
          Line(points = {{2, 22}, {18, 22}}));
        connect(sepExcDCM.flange, inertia.flange) annotation(
          Line(points = {{60, 16}, {76, 16}}));
        connect(sepExcDCM.n_ex, ground.p) annotation(
          Line(points = {{18, 6}, {12, 6}, {12, -30}}));
        connect(sepExcDCM.flange, angSpeedSensor.flange_b) annotation(
          Line(points = {{60, 16}, {80, 16}, {80, -50}, {72, -50}}));
        connect(fixed.flange, angSpeedSensor.flange_a) annotation(
          Line(points = {{28, -64}, {52, -64}, {52, -50}}));
  connect(controlledVoltage.p, resistor.p) annotation(
          Line(points = {{-44, 20}, {-44, 48}, {-32, 48}}));
  connect(controlledVoltage.n, ground.p) annotation(
          Line(points = {{-44, 0}, {-44, -30}, {12, -30}}));
  connect(stepSource.y, add.u1) annotation(
          Line(points = {{-152.4, 16}, {-136.4, 16}}));
  connect(angSpeedSensor.y, add.u2) annotation(
          Line(points = {{62, -62}, {62, -80}, {-150, -80}, {-150, 4}, {-136, 4}}));
  connect(add.y, gain.u) annotation(
          Line(points = {{-112, 9.8}, {-96, 9.8}}));
  connect(gain.y, controlledVoltage.u) annotation(
          Line(points = {{-72, 10}, {-55, 10}}));
  connect(resistor1.p, controlledVoltage.p) annotation(
          Line(points = {{-18, 22}, {-26, 22}, {-26, 32}, {-44, 32}, {-44, 20}}));
      protected
      end ControlledDCMotor;
    end Examples;
  end ControlSystems;

  package Utilities
    package Functions
      function LookUpTable
        input Real x;
        input Real[:] xdata;
        input Real[:] ydata;
        output Real y;
      protected
        Integer k;
      algorithm
        k := 1;
        while x > xdata[k + 1] and k < size(xdata, 1) - 1 loop
          k := k + 1;
        end while;
        y := (ydata[k + 1] - ydata[k]) / (xdata[k + 1] - xdata[k]) * (x - xdata[k]) + ydata[k];
      end LookUpTable;

      function TF2SS
        input Real num[:];
        input Real den[:];
        output Real A[size(den, 1) - 1, size(den, 1) - 1];
        output Real B[size(den, 1) - 1, 1];
        output Real C[1, size(den, 1) - 1];
        output Real D[1, 1];
      protected
        Integer n, m;
        Real num2[size(den,1)];
      algorithm
        n := size(den, 1) - 1;
        if size(den, 1)==size(num, 1) then
          D[1,1]:=num[1]/den[1];
          num2:=num-D[1,1]*den;
        else
          D[1, 1] := 0;
          num2:= 0 * den;
          num2[n-size(num,1)+2:n+1]:=num;
        end if;
        B[n, 1] := 1;
        for i in 1:n loop
          A[n, i] := -den[n + 2 - i] / den[1];
          C[1, i] := num2[n + 2 - i] / den[1];
        end for;
        if n > 1 then
          A[1:n - 1, 2:n] := identity(n - 1);
          A[1:n - 1, 1] := zeros(n - 1);
          B[1:n - 1, 1] := zeros(n - 1);
        end if;
      end TF2SS;
    end Functions;
  end Utilities;
  annotation(
    uses(Modelica(version = "3.2.3")));
end DSFLib;
