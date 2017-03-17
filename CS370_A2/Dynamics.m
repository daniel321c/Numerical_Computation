function dydt = Dynamics(t,y)
    dydt = y + 3 * cos(3*t)*exp(t) - 3*t +2;
end