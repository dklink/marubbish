test_typos();

disp("All Tests Passed");

%plot_T_dependence();
%plot_I_dependence();

function plot_T_dependence()
    I = kooi_constants.I_m; % mol quanta m^-2 s^-1
    T = linspace(-2, 37, 100);  % Celsius
    ratio = chl_to_carbon_ratio(T, I);
    
    plot(T, ratio);
    xlabel("T (Celsius)");
    ylabel("chlorophyll-a : C");
end

function plot_I_dependence()
    I = linspace(0, kooi_constants.I_m*2, 100); % mol quanta m^-2 s^-1
    T = 25;  % Celsius
    ratio = chl_to_carbon_ratio(T, I);
    
    plot(I, ratio);
    xlabel("I (mol quanta m^{-2} s^{-1})");
    ylabel("chlorophyll-a : C");
end

function test_typos()
    % retype equation to check
    I = kooi_constants.I_m; % mol quanta m^-2 day^-1
    T = 25;  % Celsius
    
    A = .003 + .0154 * exp(0.050*T) * exp(-0.059 * I*constants.seconds_per_day) * 1;
    B = chl_to_carbon_ratio(T, I);
    assert_equal(A, B);
end