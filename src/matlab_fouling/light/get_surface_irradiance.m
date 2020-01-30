function I_surf = get_surface_irradiance(lat, lon, dt)
%GET_SURFACE_IRRADIANCE get instantaneous surface irradiance using solar
% geometry.  Assumes no cloud cover.  Method from Khavrus & Shelevytsky 2012
%   lat: latitude (Degrees N)
%   lon: longitude (Degrees E)
%   dt: date and time of query, UTC (matlab datetime object)
%   returns: surface irradiance (W m^-2)
    alpha = deg2rad(23.45); % Earth's axial tilt (radians)
    phi = deg2rad(lat);
    I_max = 1360;  % ave solar irradiance outside atmosphere (W m^-2) (Khavrus 2012 near eq. 2)
    T = day(dt, 'dayofyear') -  day(datetime(2020, 3, 20), 'dayofyear');
        % date counted from spring equinox (20 Mar)
    dt_local = dt + days(1) * lon/360; % convert to local solar time
                                        % (assuming UTC ~ GMT solar time)
    t = minutes(timeofday(dt_local));
        % local solar time in minutes from midnight of day T
    
    theta = alpha*sin(2*pi*T/365.25);  % eq. 3
    z = sin(phi).*sin(theta) - cos(phi).*cos(theta).*cos(2*pi*t/1440);  % eq. 3
    z(z < 0) = 0;  % sun's height in the sky is zero when it has set
    
    AM = 1./(z + .50572*(6.07995 + asin(z)).^-1.6364); % eq. 8
    % optical air mass value (basically scales how much light reaches the
        % surface due to increased effective atmospheric thickness when
            % sun is at a low elevation above horizon)
    
    I_GN = 1.1*1.353*.7.^(AM.^.678);  % eq. 11
    % total global irradiance reaching the earth's surface on a cloudless
        % day on a plane perpendicular to the sun's rays
        
    I_surf = I_max * I_GN .* z;  % eq. 5, I_GN replaces I_max
    
end

