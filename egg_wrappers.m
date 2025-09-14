%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;

% %compute the perimeter of the egg
% [V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
% %plot the perimeter of the egg
% plot(V_list(1,:),V_list(2,:),'k');
% hold on
% [x_bound, y_bound] = compute_bounding_box(x0,y0,theta,egg_params)
% rectangle(Position=[x_bound(1),y_bound(1),x_bound(2)-x_bound(1),y_bound(2)-y_bound(1)],EdgeColor="c")
% 
% t=0:0.05:10;
% [x,y,theta] = egg_trajectory01(t);
% figure;
% plot(x,y,".")
ground = -10;
wall = 35;

[t_g, t_w]=collision_func(@egg_trajectory01, egg_params, ground, wall)

t_min = min(t_g,t_w);

%set up the plotting axis
hold on; axis equal; axis square
axis([0,wall+5,ground-5,(wall+ground)])
%initialize the plot of the square
fig_plot = plot(0,0,'k');
yline(ground);
xline(wall);
%iterate through time
for t=0:.01:t_min
    [x_cen, y_cen, theta] = egg_trajectory01(t);
    [V_list, G_list] = egg_func(linspace(0,1,100),x_cen,y_cen,theta,egg_params);
    %update the coordinates of the square plot
    set(fig_plot,'xdata',V_list(1,:),'ydata',V_list(2,:));
    
    %update the actual plotting window
    drawnow;
    pause(0.01)
end

%Example parabolic trajectory
function [x0,y0,theta] = egg_trajectory01(t)
    x0 = 7*t + 8;
    y0 = -6*t.^2 + 20*t + 6;
    theta = 5*t;
end