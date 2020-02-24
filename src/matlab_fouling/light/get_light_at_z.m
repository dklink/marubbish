function I_z = get_light_at_z(z, I_surf, chl_ave)
%GET_LIGHT_AT_Z equation from Lorenzen, 1972
%   z: depth (m, positive down)
%   I_surf: light intensity at surface (mol quanta m^-2 s^-1)
%   chl_ave: average chlorophyll concentration between surface and z (kg m^-3)
    K_1 = .0384; % extinction coefficient of seawater (m^-1), Lorenzen, just after eq. 3
    K_2 = .0138; % extinction coefficient of  chlorophyll (m^-1 (mg chl m^-2)^-1), Lorenzen, just after eq. 3
    CHL = chl_ave*1e6*z;  % total chlorophyll above z (mg chl m^-2)
    KZ = K_1*z + K_2*CHL;  % eq. 3, assuming only chlorophyll in water column (unitless)
    I_z = I_surf * exp(-KZ); % from eq. 1
end
