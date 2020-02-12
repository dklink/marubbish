% seems ok, can't find any other papers using a hill function for this though
first_100m();
whole_profile(); 

function first_100m()
    figure;
    z = linspace(0, 100);
    plot(S_vs_z(z), z);
    set(gca, 'YDir', 'reverse');
    xlabel('Salinity (g / kg)');
    ylabel('depth (m)');
end

function whole_profile()
    figure;
    z = linspace(0, 2000, 1000);
    plot(S_vs_z(z), z);
    set(gca, 'YDir', 'reverse');
    xlabel('Salinity (g / kg)');
    ylabel('depth (m)');
end