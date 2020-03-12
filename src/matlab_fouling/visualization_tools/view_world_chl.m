function [lat, lon, data] = view_world_chl(lat_range, lon_range, t_range, horiz_stride, vert_stride)
%VIEW_WORLD_CHL plot world map of surface chlorophyll
%   Detailed explanation goes here
	CHL = load_3d_hyperslab(Paths.chlorophyll, 'chlor_a', lon_range, lat_range, t_range);
    
    data = mean(CHL.data, 4, 'omitnan');  % collapse time dimension if it exists
    lat = CHL.lat;
    lon = CHL.lon;
    
    % smallify things
    lat = lat(1:vert_stride:end);
    lon = lon(1:horiz_stride:end);
    data = data(1:horiz_stride:end, 1:vert_stride:end);
    [LAT, LON] = meshgrid(lat, lon);
        
    f = figure; hold on;
    m_proj('miller', 'lon', 180);
    [proj_LON, proj_LAT] = m_ll2xy(LON, LAT);
    [~, h] = contourf(proj_LON, proj_LAT, log(data));
    colormap(f, 'winter');
    set(h,'LineColor','none');
    colorbar();
    m_coast();
    m_grid();
    xlabel('lon (deg E)');
    ylabel('lat (deg N)');
    title('log chlorophyll, mg m^{-3}'); 
end
