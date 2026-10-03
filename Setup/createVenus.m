function cb = createVenus(sunBody)
    % Creates the Venus Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end

    name = "Venus";
    sma = 1.08209e8; % km
    ecc = 0.00676;
    inc = 3.39; % deg
    raan = 76.680; % deg
    argp = 54.884; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 19414080; % s
    propstep = 1e4; % s
    orbitcolor = "#00CC66";
    markercolor = "#00CC66";
    mu = 3.24859e5; % km^3/s^2
    radius = 6051.8; % km
    texture = "Venus.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end