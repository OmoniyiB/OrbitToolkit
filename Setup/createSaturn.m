function cb = createSaturn(sunBody)
    % Creates the Saturn Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end

    name = "Saturn";
    sma = 1.42910e9; % km
    ecc = 0.05468;
    inc = 2.49; % deg
    raan = 113.665; % deg
    argp = 339.392; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 931655520; % s
    propstep = 1e5; % s
    orbitcolor = "#E60000";
    markercolor = "#E60000";
    mu = 3.79406e7; % km^3/s^2
    radius = 60268; % km
    texture = "Saturn.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end