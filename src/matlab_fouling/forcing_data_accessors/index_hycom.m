function variable = index_hycom(dataset_path, variable_name, seek_lon, seek_lat, seek_z, seek_time)
%INDEX_HYCOM robustly extracts records from the provided hycom netcdf dataset,
%              nearest to the provided time, lat, lon, and z coordinates
%       seek_lon, seek_lat, seek_z can be vectors of length n, corresponding to
%       n coordinate pairs.  seek_time must be scalar.
%   dataset_path: absolute path to a netcdf dataset with dimensions (lon, lat, depth, time)
%   variable_name: name of the variable to extract
%   seek_lon: longitude (Deg E)
%   seek_lat: latitude (Deg N)
%   seek_z: depth (m, positive down)
%   seek_time: time (Matlab datetime object)
    seek_lon = mod(seek_lon, 360);  % make negative lons positive
    seek_time = hours(seek_time - datetime(2000, 01, 01, 00, 00, 00));  % convert to format stored in netcdf: hours since 2000-01-01T00:00:00
    
    ncid = dataset_path;
    lon = ncread(ncid, 'lon');
    lat = ncread(ncid, 'lat');
    z = ncread(ncid, 'depth');
    time = ncread(ncid, 'time');
    
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
    
    var = ncread(ncid, variable_name, [1, 1, 1, time_idx], [inf, inf, inf, 1]);  % load only 2d field
    % this generates n linear indices, one for each (lon,lat,z) coordinate set
    linear_idx = sub2ind(size(var), lon_idx, lat_idx, z_idx);
    
    variable = var(linear_idx);
end
