plot_I_dependence();  % linear if using kooi's light units, proper looking if using Bernard's units
disp("All Tests Passed");

function plot_I_dependence()
    I = linspace(0, kooi_constants.I_m);  % mol quanta m^-2 s^-1
    growth = optimal_temp_algae_growth(I);
    figure(); hold on;
    plot(I, growth);
    xlabel("I (mol quanta m^{-2} s^{-1})");
    ylabel("Growth rate (s^{-1})");
    yline(kooi_constants.mu_max, '--', '\mu_{max}');
    xline(kooi_constants.I_m, '--', 'I_m');
    
    %or..., as Benard notes, can use a Michaelis-Menten model
    k = 15.0e-6; % mol quanta m^-2 s^-1
    growth2 = kooi_constants.mu_max * (I ./ (I + k));
    plot(I, growth2);
end