function chl_tot = get_chl_above_z_mixed(z, chl_surf, chl_z)
%GET_CHLOROPHYLL_ABOVE_Z_MIXED return depth integrated chlorophyll profile for mixed waters (0 to z)
%   z: depth (m), vector length n
%   chl_surf: concentration of chl_a at surface (mg m^-3), scalar
%   chl_z: concentration of chl at each z
%   return: chlorophyll-a concentration above depth z (mg m^-2), vector length n

    % symoblic integration of chl_vs_z_mixed by parts
    z_eu = UitzConstants.ave_Z_eu_mixed(UitzConstants.mixed_concentration_class(chl_surf));
    
    chl_tot = zeros(1, length(z));
    
    case1 = (z <= z_eu);
    chl_tot(case1) = chl_surf*z(case1);
    
    case2 = ((z_eu < z) & (z < 3*z_eu));
    chl_tot(case2) = 2*chl_surf*z_eu - ...  % total amount in profile, then subtract off...
                    .5 * (3*z_eu - z(case2)) .* chl_z(case2); % area of triangle below z)
    
    case3 = (z >= 3*z_eu);
    chl_tot(case3) = 2*chl_surf*z_eu;
end
