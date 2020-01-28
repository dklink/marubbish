test_sanity();
disp("All Tests Passed");

%plot_S_dependency(); increases with S, ok
%plot_T_dependency(); decreases with T, ok

function plot_S_dependency()
    S = linspace(30, 40, 100);  % g kg^-1
    T = 20; % Celsius
    mu_sw = dynamic_viscosity_seawater(S, T);
    plot(S, mu_sw);
    xlabel("S (g/kg)");
    ylabel("mu_{sw}");
end

function plot_T_dependency()
    T = linspace(-2, 37, 100); % Celsius
    S = 35; % g kg^-1
    mu_sw = dynamic_viscosity_seawater(S, T);
    plot(T, mu_sw);
    xlabel("T (Celsius)");
    ylabel("mu_{sw}");
end

function test_sanity()
    % not much to test other than typos, so retyping from Sharqawy 2010
    % and hey, I did catch a typo!  Useful after all...
    S = 35; % g kg^-1
    T = 20; % Celsius
    
    A = 1.541 + 1.998e-2 * T - 9.52e-5*T^2;
    B = 7.974 - 7.561e-2 * T + 4.724e-4 * T^2;
    mu_w = 4.2844e-5 + (.157*(T+64.993)^2 - 91.296)^-1;
    
    mu_sw = mu_w * (1 + A * S + B * S^2);
    
    A = mu_sw;
    B = dynamic_viscosity_seawater(S, T);

    assert_equal(A, B);
end