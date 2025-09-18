p_bisection = 1;
k_bisection = 0.5;
p_newton = 2;
k_newton = 0.0379;
p_secant = 1.6180;
k_secant = 0.3023;

e0 = 0.1;
dp = 10^-14;

convergence_test(e0, p_bisection, k_bisection, dp)
convergence_test(e0, p_newton, k_newton, dp)
convergence_test(e0, p_secant, k_secant, dp)

function steps = convergence_test(e_initial, p, k, dp)
    if e_initial<dp
        steps = 0;
    else
        steps = 1+convergence_test(k*e_initial^p, p,k, dp);
    end
end