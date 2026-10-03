function cb = createJupiter(sunBody)
    % Creates the Jupiter Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end

    name = "Jupiter";
    sma = 7.78321e8; % km
    ecc = 0.04846;
    inc = 1.30; % deg
    raan = 100.464; % deg
    argp = 273.867; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 374329728; % s
    propstep = 1e5; % s
    orbitcolor = "#9C2BFF";
    markercolor = "#9C2BFF";
    mu = 1.26713e8; % km^3/s^2
    radius = 71492; % km
    texture = "Jupiter.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end