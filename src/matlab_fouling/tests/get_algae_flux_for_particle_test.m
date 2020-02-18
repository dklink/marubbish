plot_vs_algae_count();  %shows collisions seed the fouling, but once algae has
                        %accumulated, growth/death dominates flux
plot_vs_light();
                        
function plot_vs_algae_count()
    S = 35;  % normal S and T
    T = 25; 
    chl = 5; % lots
    I = kooi_constants.I_m; % noon surface light
    A = linspace(0, 1e6, 100);
    p = [];
    
    collisions = zeros(1, 100);
    growth = zeros(1, 100);
    mortality = zeros(1, 100);
    respiration = zeros(1, 100);
    
    for i=1:100
        p = Particle(.001, 940, A(i), 0, 0, 10);
        collisions(i) = get_algae_collisions(p, S, T, chl, I);
        growth(i) = get_algae_growth(p, T, I);
        mortality(i) = get_algae_mortality( p);
        respiration(i) = get_algae_respiration( p, T);
    end
    
    figure;
    hold on;
    set(0, 'DefaultLineLineWidth', 2);
    plot(A, collisions, 'DisplayName','collisions');
    plot(A, growth, 'DisplayName','growth');
    plot(A, -mortality, 'DisplayName','mortality');
    plot(A, -respiration, 'DisplayName','respiration');
    plot(A, collisions+growth-mortality-respiration, 'DisplayName','total');
    xlabel("Algae count on particle");
    ylabel("Algae flux (cells per s)");
    hold off;
    legend;
end

function plot_vs_light()
    S = 35;  % normal S and T
    T = 25; 
    chl = 5; % lots
    I = linspace(0, kooi_constants.I_m); % proxy for euphotic zone
    p = Particle(.001, 940, 1e5, 0, 0, 10);
    
    collisions = zeros(1, 100);
    growth = zeros(1, 100);
    mortality = zeros(1, 100);
    respiration = zeros(1, 100);
    
    for i=1:100
        collisions(i) = get_algae_collisions(p, S, T, chl, I(i));
        growth(i) = get_algae_growth(p, T, I(i));
        mortality(i) = get_algae_mortality(p);
        respiration(i) = get_algae_respiration( p, T);
    end
    
    figure;
    hold on;
    set(0, 'DefaultLineLineWidth', 2);
    plot(I, collisions, 'DisplayName','collisions');
    plot(I, growth, 'DisplayName','growth');
    plot(I, -mortality, 'DisplayName','mortality');
    plot(I, -respiration, 'DisplayName','respiration');
    plot(I, collisions+growth-mortality-respiration, 'DisplayName','total');
    xlabel("light intensity (mol quanta m^-2 s^-1)");
    ylabel("Algae flux (cells per s)");
    hold off;
    legend;
end