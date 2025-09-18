function x_loc = get_distance(angle, B, m, g, V, t)
    v0x = V*cosd(angle);
    v0y = V*sind(angle);
    [t, sol] = ode45(@(t,S) dSdt(t, S, B, m, g), [0, t], [0,v0x,0,v0y]);
    just_above_idx = find(diff(sign(sol(:,3))) < 0, 1);
    if isempty(just_above_idx)
        x_loc = sol(end,1);  % return the last x position if the object didn't land
    else
        just_below_idx = just_above_idx + 1;
        x_loc = (sol(just_above_idx,1) + sol(just_below_idx,1))/2;
    end
end