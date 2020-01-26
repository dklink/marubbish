classdef CalbetConstants
    %CalbetConstants contains (grazing) mortality rate constants from Calbet 2004
    
    properties (Constant)
        tropical_mortality = .50 / constants.seconds_per_day; % "tropical/subtropical" (s^-1)
        temperate_mortality = .41 / constants.seconds_per_day; % "temperate/subpolar" (s^-1)
        polar_mortality = .16 / constants.seconds_per_day; % "polar" (s^-1)
        
        % Calbet did not define these regions; so, I use ametsoc's defs
        subtropical_lat_max = 35; % degrees N/S, http://glossary.ametsoc.org/wiki/Subtropics
        temperate_lat_max = 66.5; % degreees N/S http://glossary.ametsoc.org/wiki/Arctic_circle
    end
    
    methods (Static)
        function m = getAlgaeMortality(lat)
            %getAlgaeMortality returns mortality value based on region
            % lat: latitude (Degrees N)
            % returns: regional algae mortality rate (s^-1)
            if abs(lat) < subtropical_lat_max
                m = tropical_mortality;
            elseif abs(lat) < temperate_lat_max
                m = temperate_mortality;
            else
                m = polar_mortality;
            end
        end
    end
end

