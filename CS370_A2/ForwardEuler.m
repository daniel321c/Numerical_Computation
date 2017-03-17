function y = ForwardEuler(t0, tfinal, N, y0)

    y = zeros (1,N+1);
    y(1) = y0;
    h = (tfinal - t0)/N;
    
    for i = 2 : N+1
        
        t = t0 + h * (i - 2);
        
        y(i) = y(i-1) + h * Dynamics(t, y(i-1));
    
    end

end