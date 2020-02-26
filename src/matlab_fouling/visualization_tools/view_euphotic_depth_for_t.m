function z = view_euphotic_depth_for_t(t, lat, lon)
%VIEW_EUPHOTIC_DEPTH_FOR_T display euphotic depth at location along a time vector
% at a location
%   t: vector of datetime
%   lat: latitude (deg N)
%   lon: longitude (deg E)
    I_surf = get_surface_PAR(lat, lon, t);
    I_surf_mean = mean(I_surf);
    CHL = load_3d_hyperslab(Paths.chlorophyll, 'chlor_a', [lon, lon], [lat, lat], [t(1), t(end)]);
    z = zeros(1, length(t));
    for i=1:length(t)
        z(i) = find_euphotic_depth(I_surf(i), CHL.select(lon, lat, 0, t(i)), I_surf_mean);
    end
    figure;
    plot(t, z);
    ylabel('Z_{eu} (m)');
    set(gca, 'ydir', 'reverse');
end

function z = find_euphotic_depth(I_surf, chl_surf, I_surf_mean)
    if I_surf <= .01*I_surf_mean
        z = 0;
    else
        z = fzero(@I_z_minus_one_percent, 0); 
    end
    function ret = I_z_minus_one_percent(z)
        % for finding euphotic depth
        chl_tot = chl_surf*z;%get_chl_above_z_mixed(z, chl_surf);
        ret = get_light_at_z(z, I_surf, chl_tot) - .01*I_surf_mean;
    end
end