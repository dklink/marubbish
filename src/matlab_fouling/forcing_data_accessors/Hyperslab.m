classdef Hyperslab
    %HYPERSLAB hold subset of a netcdf file with dims (lon, lat z, time)
    properties
        lon
        lat
        z
        time
        data
    end
    
    methods
        function obj = Hyperslab(lon, lat, z, time, data)
            %HYPERSLAB constructor
            obj.lon = lon;
            obj.lat = lat;
            obj.z = z;
            obj.time = time;
            obj.data = data;
        end
        
        function value = select(obj, seek_lon, seek_lat, seek_z, seek_time)
            % selects the nearest scalar out of obj.data to provided coordinates
            [~, lon_idx] = min(abs(obj.lon-seek_lon));
            [~, lat_idx] = min(abs(obj.lat-seek_lat));
            [~, z_idx] = min(abs(obj.z-seek_z));
            [~, time_idx] = min(abs(obj.time-seek_time));
            
            value = obj.data(lon_idx, lat_idx, z_idx, time_idx);
        end
    end
end