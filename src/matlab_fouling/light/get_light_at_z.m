function I_z = get_light_at_z(z, I_surf, chl_tot)
%GET_LIGHT_AT_Z equation from Lorenzen, 1972
%   z: depth (m, positive down)
%   I_surf: light intensity at surface (mol quanta m^-2 s^-1)
%   chl_tot: depth-integrated chlorophyll concentration above z (mg m^-2)
    
    K_1 = .0384; % extinction coefficient of seawater (m^-1), Lorenzen, just after eq. 3
    K_2 = .0138; % extinction coefficient of  chlorophyll (m^-1 (mg chl m^-2)^-1), Lorenzen, just after eq. 3
    KZ = K_1*z + K_2*chl_tot;  % eq. 3, assuming only chlorophyll in water column (unitless)
    I_z = I_surf * exp(-KZ); % from eq. 1
end
