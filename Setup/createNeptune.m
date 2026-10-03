function cb = createNeptune(sunBody)
    % Creates the Neptune Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end

    name = "Neptune";
    sma = 4.50489e9; % km
    ecc = 0.00911;
    inc = 1.77; % deg
    raan = 131.784; % deg
    argp = 276.336; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 5214849120; % s
    propstep = 1e6; % s
    orbitcolor = "#0000FF";
    markercolor = "#0000FF";
    mu = 6.83653e6; % km^3/s^2
    radius = 24764; % km
    texture = "Neptune.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end