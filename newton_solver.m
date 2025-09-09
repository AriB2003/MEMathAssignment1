% Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function [x, success] = newton_solver(fun,x0)
%NEWTON_SOLVER Newton's method root solver
%   fun: callable that returns [f,dfdx]
%   x0: starting x guess
%   x: zero if found or closest iteration
    a_thresh = 10^-14;
    b_thresh = 10^-14;
    last_xn = x0-2*a_thresh;
    xn = x0;
    [fxn,fdxn] = fun(xn);
    success = false;
    while abs(xn-last_xn)>a_thresh && abs(fxn)>b_thresh && fdxn~=0
        last_xn = xn;
        diff = fxn/fdxn;
        if diff>1000
            break
        end
        xn = xn - diff;
        [fxn,fdxn] = fun(xn);
    end
    x = xn;
    if abs(fxn)<0.1
        success = true;
    end
end