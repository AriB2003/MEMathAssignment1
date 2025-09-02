test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

x_left1 = -10
x_right1 = 25

x_left2 = 25
x_right2 = 36

bisection_solver(test_func01,x_left1,x_right1)
bisection_solver(test_derivative01,x_left2,x_right2)

function x = bisection_solver(fun,x_left,x_right)

while 1
       x_mid = (x_left + x_right)/2;
       if abs(fun(x_mid)) < 0.0001
          fun(x_mid)
          x_mid
           break
       end
   
       if fun(x_mid) > 0 && fun(x_left) < 0
            x_left = x_left;
            x_right = x_mid;
       elseif fun(x_mid) < 0 && fun(x_left) > 0
            x_left = x_left;
            x_right = x_mid;
       else
           x_left = x_mid;
           x_right = x_right;
       end
   end
end