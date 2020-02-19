function salinity = get_S(seek_lon, seek_lat, seek_z, seek_time)
%GET_S extract salinity from netcdf nearest to provided coordinates
    %seek_time: time (hours since 2000-01-01T00)
    %seek_lat: latitude (Deg N)
    %seek_lon: longitude (Deg E)
    %seek_z: depth (m, positive down)
    %returns: salinity (g/kg)
    salinity = index_netcdf(Paths.salinity, 'salinity', seek_lon, seek_lat, seek_z, seek_time);
end
