function c = c_vs_zeta_stratified(zeta, Si)
%CHL_VS_Z_STRATIFIED the shape of profile of chlorophyll_a in stratified
%                       waters given by Uitz 2006
%   zeta: dimensionless depth (depth / euphotic depth), vector length n
%   Si: concentration class of surface chlorophyll, scalar
%   return: dimensionless chlorophyll concentration at depth zeta ((chl_a concentration at zeta) / (mean chl_a concentration in euphotic layer)), vector length n
    
    % all these have 9 entries corresponding to concentration classes S1, S2, ..., S9
    C_b = UitzConstants.C_b_stratified;
    s = UitzConstants.s_stratified;
    C_max = UitzConstants.C_max_stratified;
    zeta_max = UitzConstants.zeta_max_stratified;
    delta_zeta = UitzConstants.delta_zeta_stratified;
    
    c = C_b(Si) - s(Si)*zeta + C_max(Si) * exp(-((zeta - zeta_max(Si))/delta_zeta(Si)).^2);  % Uitz eq. 7
    
    c(c < 0) = 0;  % no negative concentrations please
end
