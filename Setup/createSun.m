function cb = createSun()
    % Creates the Sun Celestial Body

    name = "Sun";
    sma = 0; % m
    ecc = 0; 
    inc = 0;  % deg
    raan = 0; % deg
    argp = 0; % deg
    nu = 0; % deg
    cenbody = struct('name',"None");
    proptime = 0; % s
    propstep = 0; % s
    orbitcolor = "#FFEF00";
    markercolor = "#FFEF00";
    mu = 1.32712e11; % km^3/s^2
    radius = 695700; % km
    texture = "Sun.jpg";
   
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu,radius,texture,sat);
end