function nu_sw = kinematic_viscosity_seawater(S, T, rho_sw)
% KINEMATIC_VISCOSITY_SEAWATER calculated according to Kooi 2017 eq. 25
% S: salinity of water parcel (g / kg)
% T: temperature of water parcel (degrees C)
% return: kinematic viscosity of water parcel (m^2 s^-1)
    mu_sw = dynamic_viscosity_seawater(S, T); % (kg m^-1 s^-1)
    
    nu_sw = mu_sw./rho_sw;   % kinematic viscosity (m^2 s^-1)
end
