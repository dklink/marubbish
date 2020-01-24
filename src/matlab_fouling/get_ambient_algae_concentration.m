function A_A = get_ambient_algae_concentration(chl, T, I)  chl_to_carbon_ratio = kooi_constants.chl_to_carbon_ratio(T, I);  A_A = chl * 1/chl_to_carbon_ratio^(-1) * 1/kooi_constants.carbon_per_algae
endfunction
