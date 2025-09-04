test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

x_left1 = -10;
x_right1 = 25;

bisection_solver(test_func01,x_left1,x_right1)

function x = bisection_solver(fun,x_left,x_right)

    x_mid = x_left;
    a_thresh = 10^-14;
    b_thresh = 10^-14;

    while abs(x_left - x_right) > a_thresh && abs(fun(x_mid)) > b_thresh
       x_mid = (x_left + x_right)/2;
       if fun(x_mid) * fun(x_left) < 0
            x_right = x_mid;
       elseif fun(x_mid) * fun(x_right) < 0
           x_left = x_mid;
       else
           break
       end
    end
    x = x_mid;
end