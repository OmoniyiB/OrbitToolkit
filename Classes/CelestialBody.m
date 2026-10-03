% Define a celestial body for orbit propagation.

classdef CelestialBody < Satellite
    properties
        mu (1,1) double                % Gravitational Parameter (km^3/s^2)
        radius (1,1) double            % Radius of Celestial body (km)
        texture (1,1) string           % Image file for rendering

    end

    methods
        % Constructor
        function obj = CelestialBody(mu, radius, texture, sat)
            if nargin == 0
                % default/placeholder body — reuse Satellite's own defaults
                sat = Satellite();
                mu = 0;
                radius = 0;
                texture = "None";
            end
        
            obj = obj@Satellite(sat.name, sat.sma, sat.ecc, sat.inc, sat.raan, sat.argp, ...
                sat.nu, sat.cenbody, sat.proptime, sat.propstep, sat.orbitcolor, sat.markercolor); % pass Satellite object to superclass
        
            % Subclass-specific assignments
            obj.mu = mu;
            obj.radius = radius;
            obj.texture = texture;
        end

        function view(obj)
            % Render the celestial body
            if obj.texture == "None"
                error("Cannot view a celestial body with default parameters");
            end
            Texture = imread(obj.texture); 
            figure; hold on;
            grid on;
            axis equal
            view(3)

            % Plot celestial body
            rad = (obj.radius); % km
            [xs, ys, zs] = sphere(50);
            h = surf(xs*rad, ys*rad, zs*rad); 
            set(h,'CData', flipud(Texture), 'FaceColor', 'texturemap', 'EdgeColor', 'none')

            xlabel('X Axis (km)');
            ylabel('Y Axis (km)');
            zlabel('Z Axis (km)');

            title([obj.name]);
        end

        function disp(obj)
            for k = 1:numel(obj)
                o = obj(k);
                fprintf('\n--Celestial Body Information--\n')
                fprintf('Name: %s\n', o.name);
                fprintf('Gravitational Parameter: %.2e km^3/s^2\n', o.mu);
                fprintf('Radius: %.2f km\n', o.radius);
                fprintf('Texture: %s\n',o.texture);
                fprintf('Semi-major axis: %.2f km\n', o.sma);
                fprintf('Eccentricity: %.2f \n', o.ecc);
                fprintf('Inclination: %.2f deg\n', o.inc);
                fprintf('Right ascension of the ascending node: %.2f deg\n', o.raan);
                fprintf('Argument of periapsis: %.2f deg\n', o.argp);
                fprintf('True anomaly: %.2f deg\n', o.nu);
                fprintf('Central body: %s\n', o.cenbody.name);
                fprintf('Propagation duration: %.2f s\n', o.proptime);
                fprintf('Propagation time step: %.2f s\n', o.propstep);
                fprintf('Orbit color: %s \n', o.orbitcolor);
                fprintf('Marker color: %s \n', o.markercolor);
            end
        end
    end
end