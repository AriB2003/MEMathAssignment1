%Define the test function and deritivate of the test function
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);

%Run secant solver for given guesses
[xr,~] = secant_solver(test_func01, 10,11);
plot_roots_single(test_func01, xr, [-15,40]);
[xr,~] = secant_solver(test_func01, 40,41);
plot_roots_single(test_func01, xr, [-15,40]);