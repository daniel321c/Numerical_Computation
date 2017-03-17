function dzdt = motion_ode(t, z)
    
    x = z(1);
    y = z(2);
    a = z(3);
    v = z(4);
    p1 = z(5);
    p2 = z(6);
  
    dpdt2 = -5*pi*(p1-1);
    dpdt = p2 
    
    g = 9.81;
    w = -4;
    m = 0.2;
    q = 1.29;
    c = 0.69;
    s = 0.005;

    dxdt = v * cos(a);
    dydt = v * sin(a);
    
    D = (c*q*s/2) * ((dxdt-w)^2 +(dydt)^2);
    
    dadt = -(g/v) * cos(a);
    dvdt = -(D/m) - g*sin(a);

    
dzdt = [dxdt; dydt; dadt; dvdt; dpdt; dpdt2];

end

