function plot_roots(fun,xr,bounds)
%PLOT_ROOTS Plots the function and the found root
%   fun: callable that returns [f,dfdx]
%   xr: x value of root
%   bounds: 2-element list of start and end bounds
    x = bounds(1):bounds(2);
    [y,~]=fun(x);
    figure;
    plot(x,y);
    hold on;
    yline(0,"b--");
    [yr,~]=fun(xr);
    plot(xr,yr,"r.","MarkerSize",20);
    xlim(bounds);
end

