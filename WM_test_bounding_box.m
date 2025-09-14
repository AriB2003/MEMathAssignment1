%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;

%compute the perimeter of the egg
[V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
%plot the perimeter of the egg
plot(V_list(1,:),V_list(2,:),'k');
hold on
[x_bound, y_bound] = WM_compute_bounding_box(x0,y0,theta,egg_params);
rectangle(Position=[x_bound(1),y_bound(1),x_bound(2)-x_bound(1),y_bound(2)-y_bound(1)],EdgeColor="c")