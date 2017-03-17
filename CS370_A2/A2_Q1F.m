t=zeros(1,26);
h=8/25;
for i = 1:26
    t(i)= 0 + (i-1)*h;
end
y_numerical = RK2(0,8,25,1);
y_analytical = sin(3*t).*exp(t) + 3*t+1;

plot(t,y_analytical,'-',t,y_numerical,'+');
    