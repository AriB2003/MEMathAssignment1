%Will and Maya do the egg bounding box code again to reinforce thier
%understand when working through the whole project as a team.

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
    
    %Call wrapper to seperate the X and Y components of the egg_func
    %functions at every point s
    egg_wrapperX2 = @(s) egg_wrapperX(s,x0,y0,theta,egg_params);
    egg_wrapperY2 = @(s) egg_wrapperY(s,x0,y0,theta,egg_params);

    x_roots = [];
    y_roots = [];

    %i = inital guesses
    %Over multuple guesses solve for each X and Y compoenet to find the
    %root at s
    for i = 0:0.2:1
        [s_root_X, successX] = secant_solver(egg_wrapperX2, i,i+.01);
        [s_root_Y, successY] = secant_solver(egg_wrapperY2, i,i+.01);

        %When roots are found in X, fun egg_func to determine position on
        %point that egg is in X
        if successX
            [Vx,~] = egg_func(s_root_X,x0,y0,theta,egg_params);
            x_roots = [x_roots, Vx];
        end

        %When roots are found in Y, fun egg_func to determine position on
        %point that egg is in Y
        if successY 
            [Vy,~] = egg_func(s_root_Y,x0,y0,theta,egg_params);
            y_roots = [y_roots, Vy];
        end
    end

    %Store only unique x or y roots found
    x_roots = unique(x_roots', "rows");
    y_roots = unique(y_roots', "rows");
    %Store range of these roots by taking the first and last stored root
    %values
    x_range = [x_roots(1,1), x_roots(end,1)];
    y_range = [y_roots(1,2), y_roots(end,2)];
end

%Wrapper function to isolate the X component of G at a given point
function x_out = egg_wrapperX(s,x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    x_out = G(1);
end

%Wrapper function to isolate the Y component of G at a given point
function y_out = egg_wrapperY(s,x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    y_out = G(2);
end
