function chl_a_z = get_chl_at_z(z, chl_surf)
%get_chl_at_z vertical profile from kooi eq. 13
%   z: depth (m)
%   chl_surf: concentration of chl_a at surface (kg m^-3)
%   return: chlorophyll-a concentration at depth z (kg m^-3)
    if chl_surf ~= kooi_constants.chl_surf_np;
        error("not implemented for this surface concentration");
    end
    
    C_b = .533;
    s = 1.72e-3;  % slope (m^-1)
    % kooi states after eq 13 that s is 'normalized slope', but this is
    % treated as a typo, as it results in nonsense.  I use her provided 'slope', not 'normalized slope'.
    C_max = 1.194;
    Z_max = 92.01;
    delta_z = 43.46;
    chl_a_z_base = .151 * 1e-6;  % kg m^-3
    Z_base = 99.9; % euphotic depth (m)
    if z > Z_base
        chl_a_z = 0;
    else
        chl_z = C_b - s*z + C_max * exp(-((z-Z_max)/delta_z)^2);
        chl_a_z = chl_z * chl_a_z_base;
    end
    
end
