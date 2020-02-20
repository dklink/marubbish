function chlorophyll = get_chl(seek_time, seek_lon, seek_lat)
%GET_CHL robustly extracts records from the NASA Aqua-MODIS chlorophyll dataset,
%              nearest to the provided time, lat, and lon coordinates
%       seek_lon and seek_lat can be vectors of length n, corresponding to
%       n coordinate pairs.  seek_time must be scalar.
%   seek_time: time (hours since 2000-01-01 00:00:00)
%   seek_lon: longitude (Deg E)
%   seek_lat: latitude (Deg N)
    seek_lon(seek_lon > 180) = seek_lon(seek_lon > 180)-360;  % adapt lon to range (-180, 180)
    
    ncid = Paths.chlorophyll;
    variable_name = 'chlor_a';
    lon = ncread(ncid, 'lon');
    lat = ncread(ncid, 'lat');
    time = ncread(ncid, 'time');
    
    expected_dims = [struct('Name', 'lon', 'Length', length(lon), 'Unlimited', 0), ...
                     struct('Name', 'lat', 'Length', length(lat), 'Unlimited', 0), ...
                     struct('Name', 'time', 'Length', length(time), 'Unlimited', 1)];
    if ~isequaln(ncinfo(ncid, variable_name).Dimensions, expected_dims)
        error('dataset %s has unexpected dimensions', ncid);
    end
    
    [~, lon_idx] = min(abs(lon-seek_lon));
    [~, lat_idx] = min(abs(lat-seek_lat));
    [~, time_idx] = min(abs(double(time)-seek_time));
    
    chl = ncread(ncid, variable_name, [1, 1, time_idx], [inf, inf, 1]);  % load only 2d field
    % this generates n linear indices, one for each (lon,lat) coordinate pair
    linear_idx = sub2ind(size(chl), lon_idx, lat_idx);

    chlorophyll = chl(linear_idx);
end
