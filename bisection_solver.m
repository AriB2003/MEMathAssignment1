function x = bisection_solver(fun,x_left,x_right)
%BISECTION_SOLVER Bisection method root solver
    %fun: callable that return f(x)
    %x_left: starting left bound
    %x_right: starting right bound
    %x: zero if found

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