function [lat, lon] = click_for_coordinates()
%CLICK_FOR_COORDINATES display world map; return coordinates clicked
%   returns: [latitude (deg N, -90 to 90), longitude (deg E, -180 to 180)]
    %display world map
    figure;
    title('Please select a location');
    m_proj('mercator');
    m_coast();
    m_grid();
    % get input
    [x, y] = ginput(1);
    % convert
    [lon, lat] = m_xy2ll(x, y);
    % clean up
    close;
end

