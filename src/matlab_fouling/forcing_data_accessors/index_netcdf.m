function variable = index_netcdf(dataset_path, variable_name, seek_lon, seek_lat, seek_z, seek_time)
%INDEX_NETCDF robustly extracts records from the provided netcdf dataset,
%              nearest to the provided time, lat, lon, and z coordinates
%       Seek coordinates can be scalar, or of size (1, n), corresponding to
        %  n records to be extracted
%   dataset_path: absolute path to a netcdf dataset with dimensions (lon, lat, depth, time)
%   variable_name: name of the variable to extract
%   seek_lon: longitude (Deg E)
%   seek_lat: latitude (Deg N)
%   seek_z: depth (m, positive down)
%   seek_time: time (hours since 2000-01-01 00:00:00)
    seek_lon = mod(seek_lon, 360);  % make negative lons positive
    
    ncid = dataset_path;
    lon = ncread(ncid, 'lon');
    lat = ncread(ncid, 'lat');
    z = ncread(ncid, 'depth');
    time = ncread(ncid, 'time');
    var = ncread(ncid, variable_name);
    
    expected_dims = [struct('Name', 'lon', 'Length', length(lon), 'Unlimited', 0), ...
                     struct('Name', 'lat', 'Length', length(lat), 'Unlimited', 0), ...
                     struct('Name', 'depth', 'Length', length(z), 'Unlimited', 0), ...
                     struct('Name', 'time', 'Length', length(time), 'Unlimited', 1)];
    if ~isequaln(ncinfo(ncid, variable_name).Dimensions, expected_dims)
        error('dataset %s has unexpected dimensions', ncid);
    end
    
    [~, lon_idx] = min(abs(lon-seek_lon));
    [~, lat_idx] = min(abs(lat-seek_lat));
    [~, z_idx] = min(abs(z-seek_z));
    [~, time_idx] = min(abs(double(time)-seek_time));
    
    % this generates n linear indices, one for each (lon,lat,z,time) coordinate set
    linear_idx = sub2ind(size(var), lon_idx, lat_idx, z_idx, time_idx);
    
    variable = var(linear_idx);
end
