%Definition of the test function and its derivative
global test_func01
global test_derivative01
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

xr = newton_solver(@fun, 10);
plot_roots(@fun, xr, [-15,40]);
xr = newton_solver(@fun, 40);
plot_roots(@fun, xr, [-15,40]);

function [f,fd] = fun(x)
    global test_func01
    global test_derivative01
    f=test_func01(x);
    fd=test_derivative01(x);
end
