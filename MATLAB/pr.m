clc;
clear vars;
close all;

B = 0.5;
m = 3;  % mass of the object
g = 9.81;  % acceleration due to gravity
V = 70 ;
t1 = 30 *pi / 180;
t2 = 45 *pi / 180;
t3 = 60 *pi / 180;
t= 5;

[t1, sol1] = ode45(@(t,S) dSdt(t, S, B, m, g), [0, t], [0,V*cos(t1),0,V*sin(t1)]);
[t2, sol2] = ode45(@(t,S) dSdt(t, S, B, m, g), [0, t], [0,V*cos(t2),0,V*sin(t2)]);
[t3, sol3] = ode45(@(t,S) dSdt(t, S, B, m, g), [0, t], [0,V*cos(t3),0,V*sin(t3)]);

angles = linspace(0, 90, 1500);
x_locs = zeros(size(angles));
for i = 1:length(angles)
    x_locs(i) = get_distance(angles(i), B, m, g, V, 3);
end

figure
plot(angles, x_locs)
xlabel('Launch Angle [degrees]')
ylabel('Maximum Distance [distance]')
[max_distance, max_idx] = max(x_locs);
max_distance_angle = angles(max_idx);
xline(max_distance_angle, '--r')
title('Distance Travelled at V=70 and B=0.5')
disp(['The maximum distance is ', num2str(max_distance), ' meters.'])
disp(['The launch angle for maximum distance is ', num2str(max_distance_angle), ' degrees.'])

% Calculate the trajectory for the angle that gives the maximum distance
t_max = max_distance_angle *pi / 180;
[t_max, sol_max] = ode45(@(t,S) dSdt(t, S, B, m, g), [0, t], [0,V*cos(t_max),0,V*sin(t_max)]);

% Add the trajectory to the x-y diagram
figure
plot(sol1(:,1),sol1(:,3), 'DisplayName', '\theta_1=30^{\circ}')
hold on
plot(sol2(:,1),sol2(:,3), 'DisplayName', '\theta_2=45^{\circ}')
plot(sol3(:,1),sol3(:,3), 'DisplayName', '\theta_3=60^{\circ}')
plot(sol_max(:,1),sol_max(:,3), 'DisplayName', ['\theta_{max}=', num2str(max_distance_angle), '^{\circ}'])
ylim([0 inf])
legend
xlabel('x [m]')
ylabel('y [m]')
title('x-y Diagram')
hold off

% Add the trajectory to the y-t diagram
figure
plot(t1, sol1(:,3), 'DisplayName', '\theta_1=30^{\circ}')
hold on
plot(t2, sol2(:,3), 'DisplayName', '\theta_2=45^{\circ}')
plot(t3, sol3(:,3), 'DisplayName', '\theta_3=60^{\circ}')
plot(t_max, sol_max(:,3), 'DisplayName', ['\theta_{max}=', num2str(max_distance_angle), '^{\circ}'])
legend
xlabel('Time [s]')
ylabel('Vertical Position [m]')
title('y-t Diagram')
hold off

% Add the trajectory to the x-t diagram
figure
plot(t1, sol1(:,1), 'DisplayName', '\theta_1=30^{\circ}')
hold on
plot(t2, sol2(:,1), 'DisplayName', '\theta_2=45^{\circ}')
plot(t3, sol3(:,1), 'DisplayName', '\theta_3=60^{\circ}')
plot(t_max, sol_max(:,1), 'DisplayName', ['\theta_{max}=', num2str(max_distance_angle), '^{\circ}'])
legend
xlabel('Time [s]')
ylabel('Horizontal Position [m]')
title('x-t Diagram')
hold off

% Add the trajectory to the v-t diagram
figure
v1 = sqrt(sol1(:,2).^2 + sol1(:,4).^2);
v2 = sqrt(sol2(:,2).^2 + sol2(:,4).^2);
v3 = sqrt(sol3(:,2).^2 + sol3(:,4).^2);
v_max = sqrt(sol_max(:,2).^2 + sol_max(:,4).^2);
plot(t1, v1, 'DisplayName', '\theta_1=30^{\circ}')
hold on
plot(t2, v2, 'DisplayName', '\theta_2=45^{\circ}')
plot(t3, v3, 'DisplayName', '\theta_3=60^{\circ}')
plot(t_max, v_max, 'DisplayName', ['\theta_{max}=', num2str(max_distance_angle), '^{\circ}'])
legend
xlabel('Time [s]')
ylabel('Velocity [m/s]')
title('v-t Diagram')
hold off
