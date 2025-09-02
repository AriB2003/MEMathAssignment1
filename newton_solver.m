% Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function x = newton_solver(fun,x0)
%NEWTON_SOLVER Newton's method root solver
%   fun: callable that returns [f,dfdx]
%   x0: starting x guess
    xn = x0;
    [fxn,fdxn] = fun(xn);
    while abs(fxn)>0.0001
        xn = xn - fxn/fdxn;
        [fxn,fdxn] = fun(xn);
    end
    x = xn;
end