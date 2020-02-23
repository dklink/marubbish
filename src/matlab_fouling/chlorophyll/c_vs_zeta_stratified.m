function c = c_vs_zeta_stratified(zeta, chl_surf)
%CHL_VS_Z_STRATIFIED the shape of profile of chlorophyll_a in stratified
%                       waters given by Uitz 2006
%   zeta: dimensionless depth (depth / euphotic depth), vector length n
%   chl_surf: concentration of chlorophyll at ocean surace (mg m^-3), scalar
%   return: dimensionless chlorophyll concentration at depth zeta ((chl_a concentration at zeta) / (mean chl_a concentration in euphotic layer)), vector length n
    
    C_b = [0.4710    0.5330    0.4280    0.5700    0.6110    0.3900    0.5690    0.8350    0.1880];
    s = [0.1350    0.1720    0.1380    0.1730    0.2140    0.1090    0.1830    0.2980         0];
    C_max = [1.5720    1.1940    1.0150    0.7660    0.6760    0.7880    0.6080    0.3820    0.8850];
    zeta_max = [0.9690    0.9210    0.9050    0.8140    0.6630    0.5210    0.4520    0.5120    0.3780];
    delta_zeta = [0.3930    0.4350    0.6300    0.5860    0.5390    0.6810    0.7440    0.6250    1.0810];
    
    % C_b(i) corresponds to chl_surf between bounds(i) and bounds(i+1), for example
    bounds = [0, .04, .08, .12, .2, .3, .4, .8, 2.2, inf];  % mg m^-3
    Si = find(bounds > chl_surf, 1) - 1;  % determines concentration category chl_surf falls into (e.g. S1, S2, etc.)
    
    
    c = C_b(Si) - s(Si)*zeta + C_max(Si) * exp(-((zeta - zeta_max(Si))/delta_zeta(Si)).^2);
end
