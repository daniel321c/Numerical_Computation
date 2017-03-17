
%
% Initialize data
%
clear all; close all;

%
% load data
%
load('data.mat','x','y','v');

% a, Raw Data
figure;
title('Raw Data');
hold on

for graphNum = 1 : length(x)

	plot(x{graphNum}, y{graphNum}, 'o');

end
grid on;
axis(v);

% b, Piecewise Linear
figure;
title('Piecewise Linear');
hold on
for graphNum = 1 : length(x)

	plot(x{graphNum}, y{graphNum});

end
grid on;
axis(v);

% c, Two Cubic Splines
figure;
title('Two Cubic Splines - Variational');
hold on;
for graphNum = 1 : length(x)

	x_plot = x{graphNum}.';
	y_plot = y{graphNum}.';
	n = length(x_plot);


	% initialize t
	t = zeros(1, n); 
	for i = 2 : n
		dt = sqrt((x_plot(i)-x_plot(i-1))^2 + (y_plot(i)-y_plot(i-1))^2);
		t(i) = t(i-1) +dt;
	end


	% refine t => tref
	tref = zeros(1, 5*(n-1)+1);
	for k = 1 : n-1
		i = 5 * (k - 1) + 1;
		dt= t(k+1) - t(k);
		tref(i)   = t(k);
		tref(i+1) = t(k) +   dt/5; 
		tref(i+2) = t(k) + 2*dt/5;
		tref(i+3) = t(k) + 3*dt/5;
		tref(i+4) = t(k) + 4*dt/5;
	end
	tref(5*(n-1)+1) = t(n);

	pp_x = csape(t, x_plot, 'variational'); 
	pp_y = csape(t, y_plot, 'variational'); 
	plot(fnval(pp_x, tref), fnval(pp_y, tref));

end
axis(v);
axis off;
grid off;


% not- a-knot end
figure;
title('Two Cubic Splines - not-a-knot end');
hold on;
for graphNum = 1 : length(x)

	x_plot = x{graphNum}.';
	y_plot = y{graphNum}.';
	n = length(x_plot);


	% initialize t
	t = zeros(1, n); 
	for i = 2 : n
		dt = sqrt((x_plot(i)-x_plot(i-1))^2 + (y_plot(i)-y_plot(i-1))^2);
		t(i) = t(i-1) +dt;
	end


	% refine t => tref
	tref = zeros(1, 5*(n-1)+1);
	for k = 1 : n-1
		i = 5 * (k - 1) + 1;
		dt= t(k+1) - t(k);
		tref(i)   = t(k);
		tref(i+1) = t(k) +   dt/5; 
		tref(i+2) = t(k) + 2*dt/5;
		tref(i+3) = t(k) + 3*dt/5;
		tref(i+4) = t(k) + 4*dt/5;
	end
	tref(5*(n-1)+1) = t(n);

	pp_x = csape(t, x_plot, 'not-a-knot'); 
	pp_y = csape(t, y_plot, 'not-a-knot'); 
	plot(fnval(pp_x, tref), fnval(pp_y, tref));

end
axis(v);
axis off;
grid off;




