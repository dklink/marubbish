function chl_a_z = chl_vs_z_stratified(z, chl_surf)
%chl_vs_z_stratified vertical profiles from Uitz 2006
%   z: depth (m), vector length n
%   chl_surf: concentration of chl_a at surface (mg m^-3), scalar
%   return: chlorophyll-a concentration at depth z (mg m^-3), vector length n
    
    % assume a euphotic depth based on chl_surf (Uitz table 3)
    % and convert z to zeta (fraction of euphotic depth)
    Z_eu = UitzConstants.ave_Z_eu_stratified;
    Si = UitzConstants.stratified_concentration_class(chl_surf);
    zeta = z/Z_eu(Si);
    
    % get the normalized concentration
    c = c_vs_zeta_stratified(zeta, Si);  % normalized concentration, chl_a(zeta)/(average [chl_a] in euphotic zone)
    
    % now, we scale the normalized concentration to the real concentration
    % not by estimating average [chl_a] in euphotic zone,
    % but by directly scaling to match surface chlorophyll, as it's the
    % value we actually know
    
    c_surf = c_vs_zeta_stratified(0, Si);
    scaling_factor = chl_surf/c_surf;   % note, if chl_surf=0, the profile will be flattened to zeros.  But, if chl_surf=0, assuming no chlorophyll through whole water column isn't entirely unreasonable.
    chl_a_z = c*scaling_factor;
end
