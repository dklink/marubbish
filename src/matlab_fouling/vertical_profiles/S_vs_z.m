function S_z = S_vs_z(z)  %eq 24 for North Pacific
    z = -1*z;  % parameterization takes z positive up
    z_fix_NP = kooi_constants.z_fix_NP;
    S_fix_NP = kooi_constants.S_fix_NP;
    b_1_NP = kooi_constants.b_1_NP;
    b_2_NP = kooi_constants.b_2_NP;
    b_3_NP = kooi_constants.b_3_NP;
    b_4_NP = kooi_constants.b_4_NP;
    b_5_NP = kooi_constants.b_5_NP;
    b_6_NP = kooi_constants.b_6_NP;
    S_z = b_1_NP*z.^5 + b_2_NP * z.^4 + b_3_NP*z.^3 + b_4_NP*z.^2 + b_5_NP*z + b_6_NP;
    
    S_z(z < z_fix_NP) = S_fix_NP;
end
