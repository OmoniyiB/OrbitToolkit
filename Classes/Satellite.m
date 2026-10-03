% Define a satellite for orbit propagation.

classdef Satellite
    properties
        name (1,1) string                   % Satellite name
        sma  (1,1) double                   % Semi-major axis (km)
        ecc  (1,1) double                   % Eccentricity
        inc  (1,1) double                   % Inclination (deg)
        raan (1,1) double                   % Right Ascension of Ascending Node (deg)
        argp (1,1) double                   % Argument of periapsis (deg)
        nu   (1,1) double                   % True anomaly (deg)
        cenbody = struct('name', "Unknown") % Central body for orbit propagation (no type, just a non-double default)
        proptime (1,1) double               % Propagation duration (s)
        propstep (1,1) double               % Propagation time step (s)
        orbitcolor (1,1) string             % Orbit color (Hexadecimal code or char identifier)
        markercolor (1,1) string            % Marker color (Hexadecimal code or char identifier)
    end

    methods

        % Constructor
        function obj = Satellite(name, sma, ecc, inc, raan, argp, nu, cenbody, proptime, propstep, orbitcolor, markercolor)
            % Default values
            defaults = struct('name', "Unknown", 'sma', 0, 'ecc', 0, 'inc', 0, 'raan', 0, 'argp', 0, 'nu', 0, ...
                'cenbody', struct('name',"Unknown") ...
                ,'proptime', 0, 'propstep', 0, 'orbitcolor', '#FF0000', 'markercolor', '#FF0000');

            % If zero inputs, return object with defaults
            if (nargin == 0)
                fn = fieldnames(defaults);
                for k = 1:numel(fn)
                    obj.(fn{k}) = defaults.(fn{k});
                end
                return
            end

            % Gather provided args and validate count
            args = {name, sma, ecc, inc, raan, argp, nu, cenbody, proptime, propstep, orbitcolor, markercolor};
            if (nargin < numel(args))
                error('Not enough input arguments. Expected %d, got %d.', numel(args), nargin);
            end

            % Assign properties
            if ~(isstruct(cenbody) || isa(cenbody,'CelestialBody')) || ~isfield(cenbody,'name') && ~isprop(cenbody,'name')
                error('cenbody must be of type CelestialBody');
            end

            obj.name        = name;
            obj.sma         = sma;
            obj.ecc         = ecc;
            obj.inc         = inc;
            obj.raan        = raan;
            obj.argp        = argp;
            obj.nu          = nu;
            obj.cenbody     = cenbody;
            obj.proptime    = proptime;
            obj.propstep    = propstep;
            obj.orbitcolor  = orbitcolor;
            obj.markercolor = markercolor;
        end

        function propagate(obj)
            % Propagate a Satellite's orbit using the defined keplerian
            % orbital elements around its central body

            if isstruct(obj.cenbody)
                error("No central body is defined for orbit propagation")
            end

            [r_ijk, v_ijk] = coe2rv(obj.sma, obj.ecc, obj.inc, obj.raan, obj.argp, obj.nu, obj.cenbody.mu);
            init_cond = [r_ijk; v_ijk]; % Initial conditions in (m) and (m/s)
            tSpan = 0:obj.propstep:obj.proptime;

            mu = obj.cenbody.mu * 1e9; % convert km^3/s^2 -> m^3/s^2
            options = odeset('RelTol', 1e-10, 'AbsTol', 1e-10*(ones(1,6)));
            [~, soln] = ode45(@(t,x)twobodyEOM(t,x,mu), tSpan, init_cond, options);

            % Post-processing
            % Access the position and velocity for the orbit
            r = soln(:, 1:3); % m
            v = soln(:, 4:6); % m/s

            % Convert position and velocity from m to km & AU for plotting
            r_km = r / 1000; % km
            r_mag = sqrt(sum(r.^2,2)); % m
            [maxVal, ~] = max(r_mag); % maxVal = maximum distance from sat to central body in (m)
            au_conver = 149597870700; % Conversion factor (1 AU -> m)
            r_au = r / au_conver;


            % Plot setup
            Texture = imread(obj.cenbody.texture); % Image render for celestial body
            figure; hold on;
            grid on;
            axis equal
            view(3)

            % At this distance the rendered sphere of the celestial body
            % becomes hard to see. Represent using the objects color properties
            if maxVal >= (au_conver*0.2)
                % Plot central body
                plot3(0,0,0, 'Linestyle', 'None', 'Marker', 'o', 'MarkerSize', 5, 'Color', obj.cenbody.markercolor, 'MarkerFaceColor', obj.cenbody.markercolor)

                xlabel('X Axis (AU)');
                ylabel('Y Axis (AU)');
                zlabel('Z Axis (AU)');
                title(obj.name + ' orbit propagation around ' + obj.cenbody.name);

                % Plot trajectory
                plot3(r_au(:,1), r_au(:,2), r_au(:,3), 'Linestyle', '-', 'Color', obj.orbitcolor)
                plot3(r_au(end,1), r_au(end,2), r_au(end,3), 'Linestyle', 'None', 'Marker','o', 'Markersize', 3, 'Color', obj.markercolor, 'MarkerFaceColor', obj.markercolor)
                legend(obj.cenbody.name, obj.name + ' orbit', obj.name, 'Location', 'bestoutside')
            else
                % Plot central body
                radius = (obj.cenbody.radius); % km
                [xs, ys, zs] = sphere(50);
                h = surf(xs*radius, ys*radius, zs*radius);
                set(h,'CData', flipud(Texture), 'FaceColor', 'texturemap', 'EdgeColor', 'none')

                xlabel('X Axis (km)');
                ylabel('Y Axis (km)');
                zlabel('Z Axis (km)');
                title(obj.name + ' orbit propagation around ' + obj.cenbody.name);

                % Plot trajectory
                plot3(r_km(:,1), r_km(:,2), r_km(:,3), 'Linestyle', '-', 'Color', obj.orbitcolor)
                plot3(r_km(end,1), r_km(end,2), r_km(end,3), 'Linestyle', 'None', 'Marker','o' ,'Color', obj.markercolor, 'MarkerFaceColor', obj.markercolor)
                legend(obj.cenbody.name, obj.name + " orbit", obj.name, 'Location', 'bestoutside')
            end
            hold off;
        end

        function disp(obj)
            for k = 1:numel(obj)
                o = obj(k);
                fprintf('\n--Satellite Information--\n');
                fprintf('Name: %s\n', o.name);
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
