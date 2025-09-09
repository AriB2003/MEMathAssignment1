%Definition of the test function and its derivative
% fun = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
fun = @(x) (x-30.879).^2;

%create graphs of results
xr = bisection_solver(fun, 15, 40)
plot_roots(fun, xr, [-15,40]);
xr = bisection_solver(fun, 20, 40);
plot_roots(fun, xr, [-15,40]);
