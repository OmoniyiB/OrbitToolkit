function cb = createMercury(sunBody)
    % Creates the Mercury Celestial Body

    if nargin < 1
        sunBody = createSun();
    end
    
    name = "Mercury";
    sma = 5.79091e7; % km
    ecc = 0.20564;
    inc = 7.01; % deg
    raan = 48.331; % deg
    argp = 29.124; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 7600608; % s
    propstep = 1e4; % s
    orbitcolor = "#FFA07A";
    markercolor = "#FFA07A";
    mu = 2.20319e4; % km^3/s^2
    radius = 2440.53; % km
    texture = "Mercury.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end