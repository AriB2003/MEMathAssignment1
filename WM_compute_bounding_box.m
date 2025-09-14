%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range] = WM_compute_bounding_box(x0,y0,theta,egg_params)
    
    egg_wrapperX2 = @(s) egg_wrapperX(s,x0,y0,theta,egg_params);
    egg_wrapperY2 = @(s) egg_wrapperY(s,x0,y0,theta,egg_params);

    x_roots = [];
    y_roots = [];
    for i = 0:0.2:1
        [s_root_X, successX] = secant_solver(egg_wrapperX2, i,i+.01);
        [s_root_Y, successY] = secant_solver(egg_wrapperY2, i,i+.01);
        if successX
            [Vx,~] = egg_func(s_root_X,x0,y0,theta,egg_params);
            x_roots = [x_roots, Vx];
        end
        if successY 
            [Vy,~] = egg_func(s_root_Y,x0,y0,theta,egg_params);
            y_roots = [y_roots, Vy];
        end
    end
    x_roots = unique(x_roots', "rows");
    y_roots = unique(y_roots', "rows");
    x_range = [x_roots(1,1), x_roots(end,1)];
    y_range = [y_roots(1,2), y_roots(end,2)];
end


function x_out = egg_wrapperX(s,x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    x_out = G(1);
end

function y_out = egg_wrapperY(s,x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    y_out = G(2);
end
