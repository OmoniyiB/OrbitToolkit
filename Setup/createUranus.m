function cb = createUranus(sunBody)
    % Creates the Uranus Celestial Body
    
    if nargin < 1
        sunBody = createSun();
    end
    
    name = "Uranus";
    sma = 2.87479e9; % km
    ecc = 0.04739;
    inc = 0.77; % deg
    raan = 74.006; % deg
    argp = 96.999; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 2658427776; % s
    propstep = 1e6; % s
    orbitcolor = "#87CEEB";
    markercolor = "#87CEEB";
    mu = 5.79456e6; % km^3/s^2
    radius = 25559; % km
    texture = "Uranus.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end