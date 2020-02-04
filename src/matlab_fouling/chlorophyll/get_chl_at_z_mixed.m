function chl_z = get_chl_at_z_mixed(z, chl_surf, z_eu)
%get_chl_at_z Simplified vertical profile, taken from Uitz 2006 mixed profile
%   z: depth (m)
%   chl_surf: concentration of chl_a at surface (mg m^-3)
%   z_eu: euphotic depth (m)
%   return: chlorophyll-a concentration at depth z (mg m^-3)

    if z < z_eu
        chl_z = chl_surf;
    elseif z < 2*z_eu
        chl_z = chl_surf - chl_surf/z_eu * (z-z_eu);  % linear decrease, chl_surf to 0, from z_eu to 2z_eu
    else
        chl_z = 0;
    end
end
