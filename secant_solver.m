function [x] = secant_solver(fun,x0, x1)
% Initialize values    
    x_n = x0;
    x_n1 = x1;
    A_thresh = 10^(-14);
    B_thresh = 10^(-14);
 
% Iterative secant method. Finds x_n+2 given x_n and x_n+1
    while 1 == 1
        % Check for convergence
        if abs(x_n-x_n1) < A_thresh || abs(fun(x_n)) < B_thresh
            break
        end

        % Evaluate function at given points
        f_n = fun(x_n);
        f_n1 = fun(x_n1);
        
        % Check to avoid division by 0
        if f_n1-f_n == 0  
            break
        end

        % Implement secant method formula
        x_n2 = x_n1 - f_n1*((x_n1-x_n)/(f_n1-f_n));
        
        % Check to make sure the step size is not ridiculous
        if abs(x_n2 - x_n1) > 1000
            break
        end 

        % Update x_n and x_n1 values
        x_n = x_n1;
        x_n1 = x_n2;
    end

    % Assign output    
    x = (x_n + x_n1)/2;
end