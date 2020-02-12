function T_z = T_vs_z(z)
    % eq 22 for North Pacific
    % z: depth (m)
    % return: Temerature at z (Celsius)
    T_surf_NP = kooi_constants.T_surf_NP;
    T_bot_NP = kooi_constants.T_bot_NP;
    p_NP = kooi_constants.p_NP;
    z_c_NP = kooi_constants.z_c_NP;
    T_z = T_surf_NP + (T_bot_NP - T_surf_NP)*(z.^p_NP ./ (z.^p_NP + z_c_NP^p_NP));
end
