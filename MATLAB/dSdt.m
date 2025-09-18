% Define function f above
function dSdt = dSdt(t, S, B, m, g)
    x = S(1);
    vx = S(2);
    y = S(3);
    vy = S(4);
    dSdt = [vx; -B*sqrt(vx^2+vy^2)*vx/m; vy; -g-B*sqrt(vx^2+vy^2)*vy/m];
end
