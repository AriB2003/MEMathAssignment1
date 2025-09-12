%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range] = compute_bounding_box(x0,y0,theta,egg_params)
    %wrapper function that calls egg_wrapper1
    %but only takes s as an input (other inputs are fixed)
    %(single input)
    egg_wrapper_horiz = @(s) egg_wrapper_x(s,x0,y0,theta,egg_params);
    egg_wrapper_vert = @(s) egg_wrapper_y(s,x0,y0,theta,egg_params);

    %compute the value of s for which the corresponding point on the oval
    %has an x-coordinate of zero
    x_roots = [];
    y_roots = [];
    for i=0:0.4:2*pi()
        [s_root, success1] = secant_solver(egg_wrapper_horiz,i,i+.01);
        [s_root2, success2] = secant_solver(egg_wrapper_vert,i,i+.01);
        if success1
            %as well as the tangent vector at that point
            [V_single, G_single] = egg_func(s_root,x0,y0,theta,egg_params);
            % %plot this single point on the egg
            % plot(V_single(1),V_single(2),'ro','markerfacecolor','r');
            x_roots = [x_roots, V_single];
        end
        if success2
            %as well as the tangent vector at that point
            [V_single, G_single] = egg_func(s_root2,x0,y0,theta,egg_params);
            % %plot this single point on the egg
            % plot(V_single(1),V_single(2),'bo','markerfacecolor','b');
            y_roots = [y_roots, V_single];
        end
    end
    x_roots = unique(x_roots', "rows");
    y_roots = unique(y_roots', "rows");
    x_range = [x_roots(1,1), x_roots(end,1)];
    y_range = [y_roots(1,2), y_roots(end,2)];
end

%wrapper function that calls egg_func
%and only returns the x coordinate of the
%point on the perimeter of the egg
%(single output)
function x_out = egg_wrapper_x(s,x0,y0,theta,egg_params)
[V, G] = egg_func(s,x0,y0,theta,egg_params);
x_out = G(1);
end
function y_out = egg_wrapper_y(s,x0,y0,theta,egg_params)
[V, G] = egg_func(s,x0,y0,theta,egg_params);
y_out = G(2);
end