function salinity = get_S(seek_time, seek_lat, seek_lon, seek_z)
%GET_S extract salinity from netcdf nearest to provided coordinates
    %seek_time: time (??? units)
    %seek_lat: latitude (Deg N)
    %seek_lon: longitude (Deg E)
    %seek_z: depth (m, positive down)
    %returns: salinity (g/kg)
    salinity = index_netcdf(Paths.salinity, 'salinity', seek_time, seek_lat, seek_lon, seek_z
end
