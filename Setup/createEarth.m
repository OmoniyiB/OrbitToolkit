function cb = createEarth(sunBody)
    % Creates the Earth Celestial Body

    if nargin < 1
        sunBody = createSun();
    end
    
    name = "Earth";
    sma = 149597870.7; % km
    ecc = 1.67e-2; 
    inc = 0;  % deg
    raan = 0; % deg
    argp = 114.21; % deg
    nu = 0; % deg
    cenbody = sunBody;
    proptime = 31558464; % s
    propstep = 1e4; % s
    orbitcolor = "#0089FF";
    markercolor = "#0089FF";
    mu = 3.986e5; % km^3/s^2
    radius = 6378; % km
    texture = "Earth.jpg";
    
    sat = Satellite(name, sma, ecc, inc, raan, argp, nu ,cenbody, proptime, propstep, orbitcolor, markercolor);
    cb = CelestialBody(mu, radius, texture, sat);
end

