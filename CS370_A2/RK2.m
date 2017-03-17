function y = ForwardEuler(t0, tfinal, N, y0)

    y = zeros (1,N+1);
    y(1) = y0;
    h = (tfinal - t0)/N;
    
    for i = 2 : N+1
        
        t_previous = t0 + h * (i - 2);
        t_current = t0 + h * (i - 1);
        
        y1 = y(i-1) + h * Dynamics(t_previous, y(i-1));
        
        y2 = y1 + h * Dynamics(t_current, y1);
        
        y(i) = (y(i-1)+y2)/2;
    
    end

end