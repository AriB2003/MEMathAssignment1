function [x, success] = bisection_solver(fun,x_left,x_right)
%BISECTION_SOLVER Bisection method root solver
    %fun: callable that return f(x)
    %x_left: starting left bound
    %x_right: starting right bound
    %x: zero if found
    %success: A flag that is True if the solver converges, False otherwise
    
    x_mid = x_left;

    % Set thresholds for closeness to root
    a_thresh = 10^-14;
    b_thresh = 10^-14;
    success = true;

    
    while abs(x_left - x_right) > a_thresh && abs(fun(x_mid)) > b_thresh
       % Find the midpoint
       x_mid = (x_left + x_right)/2;

       % Replace either the left or right midpoint depending on the sign of
       % f(x)
       if fun(x_mid) * fun(x_left) < 0
            x_right = x_mid;
       elseif fun(x_mid) * fun(x_right) < 0
           x_left = x_mid;
       else
           success = false;
           break
       end
    end
    x = x_mid;
end