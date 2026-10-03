function [dx] = twobodyEOM(~, x, mu)
%{
x(1:3) = position (x,y,z)
x(4:6) = velocity (vx,vy,vz)
mu = (gravitational parameter)
%}

r_vec = x(1:3);
r_mag = norm(r_vec);

acc = -mu * r_vec / (r_mag^3);

dx = [
    x(4);
    x(5);
    x(6);
    acc(1);
    acc(2);
    acc(3);
    ];
end 