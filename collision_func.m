%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(traj_fun, egg_params, y_ground, x_wall)
egg_wrapper_x_lower = @(t) egg_wrapper_x_max(t,traj_fun,egg_params)-x_wall;
egg_wrapper_y_lower = @(t) egg_wrapper_y_min(t,traj_fun,egg_params)-y_ground;
[t_ground, success1] = bisection_solver(egg_wrapper_x_lower,0,100);
[t_wall, success2] = bisection_solver(egg_wrapper_y_lower,0,100);
end

%wrapper function that calls egg_func
%and only returns the x coordinate of the
%point on the perimeter of the egg
%(single output)
function x_max = egg_wrapper_x_max(t,traj_fun,egg_params)
[x0,y0,theta] = traj_fun(t);
[x_bound, y_bound] = compute_bounding_box(x0,y0,theta,egg_params);
x_max = x_bound(2);
end
function y_min = egg_wrapper_y_min(t,traj_fun,egg_params)
[x0,y0,theta] = traj_fun(t);
[x_bound, y_bound] = compute_bounding_box(x0,y0,theta,egg_params);
y_min = y_bound(1);
end