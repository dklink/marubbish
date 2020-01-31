function S_z = S_vs_z(z)  %eq 24
    z = -1*z;
    z_fix_NP = -1000;
    S_fix_NP = 34.6;
    b_1_NP = 9.9979979767e-17;
    b_2_NP = 1.0536246487e-12;
    b_3_NP = 3.9968286066e-9;
    b_4_NP = 6.5411526250e-6;
    b_5_NP = 4.1954014008e-3;
    b_6_NP = 3.5172984035e1;
    S_z = b_1_NP*z.^5 + b_2_NP * z.^4 + b_3_NP*z.^3 + b_4_NP*z.^2 + b_5_NP*z + b_6_NP;
    
    S_z(z < z_fix_NP) = S_fix_NP;
end

%{
%testing the salinity profile.  No mixed layer?!?
z = linspace(0, 2000);
plot(S_vs_z(z), z);
set(gca, 'YDir', 'reverse');
%}