function chl_tot = get_chl_above_z_stratified(z, chl_surf)
%GET_CHLOROPHYLL_ABOVE_Z_STRATIFIED return depth integrated chlorophyll profile for stratified waters (0 to z)
%   z: depth (m), vector length n
%   chl_surf: concentration of chl_a at surface (mg m^-3), scalar
%   return: chlorophyll-a concentration above depth z (mg m^-2), vector length n
    chl_tot = zeros(1, length(z));
    % coarse numeric integration.  It does ok for z<250m or so, which is good enough for our purposes.
    num_samples = 10;
    for i=1:length(z)
        sample_z = linspace(0, z(i), num_samples);
        sample_prof = chl_vs_z_stratified(sample_z, chl_surf);
        chl_tot(i) = trapz(sample_z, sample_prof);
    end
end
