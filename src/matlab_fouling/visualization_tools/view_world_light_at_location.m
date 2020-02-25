function view_world_light_at_location(lat, lon, time)
%VIEW_WORLD_LIGHT_AT_LOCATION make a map of the world's light state
%   at a given time; mark the lat and lon provided
%   lat: latitude (degrees N)
%   lon: longitude (degrees E)
%   time: moment in time (matlab datetime object)
    grid_lat = linspace(-90, 90, 100);
    grid_lon = linspace(-180, 180, 100);
    [LON, LAT] = meshgrid(grid_lon, grid_lat);
    
    I_surf = get_surface_PAR(LAT, LON, time);
    
    figure; hold on;
    m_proj('satellite', 'latitude', lat, 'longitude', lon, 'altitude', 3);
    [proj_LON, proj_LAT] = m_ll2xy(LON, LAT);
    [proj_lon, proj_lat] = m_ll2xy(lon, lat);
    contourf(proj_LON, proj_LAT, I_surf);
    colorbar();
    plot(proj_lon, proj_lat, 'rp', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
    m_coast();
    m_grid();
    xlabel('lon (deg E)');
    ylabel('lat (deg N)');
    title(datestr(time)); 
end