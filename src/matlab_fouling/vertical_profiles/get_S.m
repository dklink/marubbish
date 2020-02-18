function salinity = get_S(seek_time, seek_lat, seek_lon, seek_z)
%GET_S extract salinity from netcdf nearest to provided coordinates
    %seek_time: time (??? units)
    %seek_lat: latitude (Deg N)
    %seek_lon: longitude (Deg E)
    %seek_z: depth (m, positive down)
    %returns: salinity (g/kg)
    seek_lon = mod(seek_lon, 360);  % make negative lons positive
    
    ncid = Paths.salinity;
    lon = ncread(ncid, 'lon');
    lat = ncread(ncid, 'lat');
    z = ncread(ncid, 'depth');
    time = ncread(ncid, 'time');
    S = ncread(ncid, 'salinity');
    
    expected_dims = [struct('Name', 'lon', 'Length', length(lon), 'Unlimited', 0), ...
                     struct('Name', 'lat', 'Length', length(lat), 'Unlimited', 0), ...
                     struct('Name', 'depth', 'Length', length(z), 'Unlimited', 0), ...
                     struct('Name', 'time', 'Length', length(time), 'Unlimited', 0)];
    if ~isequaln(ncinfo(ncid, 'salinity').Dimensions, expected_dims)
        error('file %s has unexpected dimensions', ncid);
    end
    
    [~, lon_idx] = min(abs(lon-seek_lon));
    [~, lat_idx] = min(abs(lat-seek_lat));
    [~, z_idx] = min(abs(z-seek_z));
    [~, time_idx] = min(abs(time-seek_time));
    
    % salinity = S(lon_idx, lat_idx, z_idx, time_idx); rn there isn't a time axis
    salinity = S(lon_idx, lat_idx, z_idx);
end
