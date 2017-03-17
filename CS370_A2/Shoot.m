function hit = Shoot(init_pos,init_theta,init_vel,init_p)


%
% Initial position and velocity
%
x0=init_pos(1);
y0=init_pos(2);
theta0=init_theta;
v0=init_vel;
p0=init_p;

%Initial Conditions
init = [x0; y0; theta0; v0; p0; 1]; %(last column is pig's initial velocity)
time_span = 0:0.05:5;

%
% Solve ODE: complete the commented call to ode45 below
%
options=odeset('Events',@events,'Refine',10,'MaxStep',0.01);
[t,z] = ode45(@motion_ode, time_span, init,options);

%
% After the calculation, plot/animate the trajectory of the triangle
%
f = figure(1);
hold on;
n=length(t);
tri_h=plot(z(1,1),z(1,2),'r>','linewidth',10,'MarkerFaceColor','r');
%set(tri_h,'erasemode','normal');
pig = findobj(f,'Tag','Pig'); % locate the pig object
% first frame:
set(tri_h,'XData',z(2,1),'YData',z(2,2));
dot_h=plot(z(1,1),z(1,2),'.','color',[1,0.5,0.5],'linewidth',4,'MarkerFaceColor','g');
set(pig,'XData',z(2,5)*[1 1]);
% next frames:
for s=3:n,
  % set coordinates for triangle
  set(tri_h,'XData',z(s,1),'YData',z(s,2));
  % append coordinates for bird trajectory
  dx=[get(dot_h,'XData') z(s-1,1)];
  dy=[get(dot_h,'YData') z(s-1,2)];
  set(dot_h,'XData',dx,'YData',dy);
  % set x-coordinates for pig
  set(pig,'XData',z(s,5)*[1 1]);
  drawnow;
  pause(0.1);
end

% detect hit
hit = norm([z(n,1)-z(n,5) z(n,2)-0.05]) < 0.05;
    
    %
    % Dynamics function for the triangle: Complete the missing parts
    %
    function dz = motion_ode(t,z)
        dz = zeros(6,1);
        %fill in the column vector dz
        x = z(1);
        y = z(2);
        a = z(3);
        v = z(4);
        p1 = z(5);
        p2 = z(6);
  
        dpdt2 = -5*pi*(p1-1);
        dpdt = p2; 
    
        g = 9.81;
        w = -4;
        m = 0.2;
        q = 1.29;
        c = 0.69;
        s1 = 0.005;

        dxdt = v * cos(a);
        dydt = v * sin(a);
        D = (c*q*s1/2) * ((dxdt-w)^2 +(dydt)^2);
        dadt = -(g/v) * cos(a);
        dvdt = -(D/m) - g*sin(a);
    
        dz = [dxdt; dydt; dadt; dvdt; dpdt; dpdt2];
    end
    
    %
    % Event function: Complete the missing parts
    %
    function [values,halt,direction]=events(t,z)

        x=z(1); 
        y=z(2);
        p=z(5);
        
        %fill in the third column here
        values    = [ y;  x-2;(x-p)^2+y^2-0.0025];
        halt      = [ 1;    1;        1   ];
        direction = [-1;    1;         0 ];

    end

end
