plot_I_dependence();  % linear if using kooi's light units, proper looking if using Bernard's units
disp("All Tests Passed");
function plot_I_dependence()
    I = linspace(0, 2*kooi_constants.I_m);  % mol quanta m^-2 s^-1
    growth = optimal_temp_algae_growth(I);
    figure();
    plot(I, growth);
    xlabel("I (mol quanta m^{-2} s^{-1})");
    ylabel("Growth rate (s^{-1})");
end