function salinity = get_S(seek_lon, seek_lat, seek_z, seek_time)
%GET_S extract salinity from netcdf nearest to provided coordinates
%       seek_lon, seek_lat, seek_z can be vectors of length n, corresponding to
%       n coordinate pairs.  seek_time must be scalar.
    %seek_time: time (Matlab datetime object)
    %seek_lat: latitude (Deg N)
    %seek_lon: longitude (Deg E)
    %seek_z: depth (m, positive down)
    %returns: salinity (g/kg)
    salinity = index_hycom(Paths.salinity, 'salinity', seek_lon, seek_lat, seek_z, seek_time);
end
