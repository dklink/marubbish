function view_surf_light_for_t(t, lat, lon)
%VIEW_SURF_LIGHT_FOR_T display surface light intensity along a time vector
% at a location
%   t: vector of datetime
%   lat: latitude (deg N)
%   lon: longitude (deg E)
    I = get_surface_PAR(lat, lon, t);
    figure;
    plot(t, I);
    ylabel('surface PAR (micro mol quanta m^{-2} s^{-1}');
end

