function T_z = T_vs_z(z)  % eq 22 for North Pacific
    T_surf_NP = 25;
    T_bot_NP = 1.5;
    p_NP = 2;
    z_c_NP = -300;
    T_z = T_surf_NP + (T_bot_NP - T_surf_NP)*(z.^p_NP ./ (z.^p_NP + z_c_NP^p_NP));
end

%{
% testing the temp profile
z = linspace(0, 100);
plot(T_vs_z(z), z);
set(gca, 'YDir', 'reverse');
%}