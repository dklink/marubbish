function chl_a_z = chl_vs_z_mixed(z, chl_surf)
%CHL_VS_Z_MIXED follows Uitz 2006's description of chl_a profile in mixed
%   waters, section 4.2.2.
%   z: depth (m), vector length n
%   chl_surf: concentration of chl_a at surface (mg m^-3), scalar
%   return: chlorophyll-a concentration at depth z (mg m^-3), vector length n
    
    % assume a euphotic depth based on chl_surf (Uitz table 3)
    Mi = UitzConstants.mixed_concentration_class(chl_surf);
    z_eu = UitzConstants.ave_Z_eu_mixed(Mi);

    chl_a_z = zeros(1, length(z));
    % profile flat until z_eu
    chl_a_z(z < z_eu) = chl_surf;
    % profile decreasese linearly after z_eu, halving by 2*z_eu (thus reaching zero at 3 z_eu)
    chl_a_z((z_eu < z) & (z < 3*z_eu)) = chl_surf - chl_surf/(2*z_eu) * (z((z_eu < z) & (z < 3*z_eu)) - z_eu);
    % profile after z_eu remains zero
end

