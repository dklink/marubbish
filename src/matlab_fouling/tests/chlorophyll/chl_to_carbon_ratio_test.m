%test_typos();

disp("All Tests Passed");

%plot_T_dependence();
%Zonneveld_fig7a(); % as close as might be expected from an entirely different model
                    % off by 2 orders magnitude with kooi's typo
%Geider_fig10(); % actually pretty reasonable, note it's at zero-light

function Geider_fig10()
    %comparison to Geider 1987 fig 10
    I = 0; % mol quanta m^-2 s^-1
    T = linspace(0, 30, 100);  % Celsius
    C_to_chl = 1./chl_to_carbon_ratio(T, I);
    
    plot(T, C_to_chl);
    xlabel("T (Celsius)");
    ylabel("theta_0");
    xlim([0, 30]);
    %ylim([0, 50]);
end

function plot_T_dependence()
    I = kooi_constants.I_m; % mol quanta m^-2 s^-1
    T = linspace(-2, 37, 100);  % Celsius
    ratio = chl_to_carbon_ratio(T, I);
    
    plot(T, ratio);
    xlabel("T (Celsius)");
    ylabel("chlorophyll-a : C");
end

function Zonneveld_fig7a()
    % comparison to Zonneveld 1998 fig7a
    I = 1e-6*linspace(0, 700, 100); % mol quanta m^-2 s^-1
    T = 25;  % Celsius
    ratio = chl_to_carbon_ratio(T, I);
    
    plot(I*1e6, ratio);
    xlim([0, 650]);
    xlabel("I (micro mol quanta m^{-2} s^{-1})");
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