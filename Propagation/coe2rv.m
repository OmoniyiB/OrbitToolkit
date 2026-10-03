function [r_ijk, v_ijk] = coe2rv(a, ecc, incl, RAAN, argp, nu, mu)
% Keplerian Orbital Elements to Position and Velocity

% All angles in degrees. Inputs a (km) and mu (km^3/s^2) are converted to meters
% and m^3/s^2 respectively so outputs r_ijk (m) and v_ijk (m/s).

a = a*1e3;      % km -> m
mu = mu*1e9;    % km^3/s^2 -> m^3/s^2
i = deg2rad(incl); O = deg2rad(RAAN); w = deg2rad(argp); nu_r = deg2rad(nu);

p = a*(1 - ecc^2);

% Position/velocity in perifocal (PQW) frame
r_pqw = [p*cos(nu_r)/(1+ecc*cos(nu_r));
    p*sin(nu_r)/(1+ecc*cos(nu_r));
    0];
v_pqw = [-sqrt(mu/p)*sin(nu_r);
    sqrt(mu/p)*(ecc+cos(nu_r));
    0];

% Rotation PQW -> IJK
R3_O = [cos(-O) -sin(-O) 0; sin(-O) cos(-O) 0; 0 0 1];
R1_i = [1 0 0; 0 cos(-i) -sin(-i); 0 sin(-i) cos(-i)];
R3_w = [cos(-w) -sin(-w) 0; sin(-w) cos(-w) 0; 0 0 1];
Q = R3_O * R1_i * R3_w;

r_ijk = Q * r_pqw;
v_ijk = Q * v_pqw;
end