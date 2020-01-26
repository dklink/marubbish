function rho_sw = get_seawater_density(S, T, lat, lon, z)
%GET_SEAWATER_DENSITY calculated using gsw TEOS-11 package
% S: salinity of water parcel (g / kg)
% T: temperature of water parcel (degrees C)
% lat: latitude of water parcel (degrees N)
% lon: longitude of water parcel (degrees E)
% z: depth of water parcel (m, positive down)
% return: in-situ density of water parcel (kg m^-3)
    % this functions takes z as positive up, hence inversion
    p = gsw_p_from_z(-1*z, lat); % sea pressure, dbar
    
    [SA, ~] = gsw_SA_from_SP(S, p, lon, lat); % [Absolute Salinity, n/a]
    CT = gsw_CT_from_t(SA, T, p); % Conservative Temperature
    rho_sw = gsw_rho(SA, CT, p);  % in-situ density (kg m^-3)
end
