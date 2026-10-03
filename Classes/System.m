% Define a system with one central body and its associated satellites.


classdef System
    properties
        centralBody (1,1) CelestialBody % Property to hold the central body object
        sats (1,:) Satellite            % Satellite array to hold satellite objects
        celesbodies (1,:) CelestialBody % CelestialBody array to hold celestial body objects
    end

    methods

        % Constructor
        function obj = System(centralBody, sats, celesbodies)
            if nargin == 0
                return
            end

            % Validate centralBody
            if ~isa(centralBody, 'CelestialBody')
                error('centralBody must be a CelestialBody object.');
            end

            % Validate sats: allow empty, single Satellite, or array of Satellite
            if nargin < 2 || isempty(sats)
                sats = Satellite.empty(1,0);
            elseif isa(sats, 'Satellite')
                % If it's a scalar or array of Satellite, ensure row orientation
                sats = reshape(sats, 1, []);
            else
                error('sats must be empty, a Satellite, or an array of Satellite objects.');
            end

            % Validate celesbodies: allow empty, single CelestialBody, or array
            if nargin < 3 || isempty(celesbodies)
                celesbodies = CelestialBody.empty(1,0);
            elseif isa(celesbodies, 'CelestialBody')
                celesbodies = reshape(celesbodies, 1, []);
            else
                error('celesbodies must be empty, a CelestialBody, or an array of CelestialBody objects.');
            end

            obj.centralBody = centralBody;
            obj.sats = sats;
            obj.celesbodies = celesbodies;
        end


        function disp(obj)
            fprintf("--System Information--\n");
            fprintf("Central Body: %s\n", obj.centralBody.name);

            fprintf("Satellites in system:\n");
            if isempty(obj.sats)
                fprintf("No Satellite objects in system\n")
            else
                for x = 1:numel(obj.sats)
                    fprintf("%s\n", obj.sats(x).name);
                end
            end

            fprintf("Celestial Bodies in system:\n");
            if isempty(obj.celesbodies)
                fprintf("No Celestial Body objects in system\n");
            else
                for y = 1:numel(obj.celesbodies)
                    fprintf("%s\n", obj.celesbodies(y).name);
                end
            end
        end
    end
end