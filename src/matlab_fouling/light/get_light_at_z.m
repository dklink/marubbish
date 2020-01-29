function I_z = get_light_at_z(z, I_surf, chl_ave)
%GET_LIGHT_AT_Z Kooi 2017 eq. 19, 21
%   z: depth (m, positive down)
%   I_surf: light intensity at surface (mol quanta m^-2 s^-1)
%   chl_ave: average chlorophyll concentration between surface and z (mg m^-3)
    eps = kooi_constants.eps_w + kooi_constants.eps_p*chl_ave; % m^-1
    I_z = I_surf*exp(eps * -z);
end
