function cb = createMars(sunBody)
    % Creates the Mars Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end

    name = "Mars";
    sma = 2.27939e8; % km
    ecc = 0.09342;
    inc = 1.85; % deg
    raan = 49.558; % deg
    argp = 286.502; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 59370048; % s
    propstep = 1e4; % s
    orbitcolor = "#FF6600";
    markercolor = "#FF6600";
    mu = 4.28284e4; % km^3/s^2
    radius = 3396.190; % km
    texture = "Mars.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end