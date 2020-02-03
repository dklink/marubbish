%plot_lat_dependence();
%plot_lon_dependence();
%plot_map();
%plot_seasons();
plot_hours();

function plot_lat_dependence()
    lat = linspace(-90, 90, 100);
    lon = 0;
    NH_winter = datetime(2020, 12, 21, 12, 0, 0);
    SH_winter = datetime(2020, 6, 21, 12, 0, 0);
    
    I_surf_NH = get_surface_irradiance(lat, lon, NH_winter);
    I_surf_SH = get_surface_irradiance(lat, lon, SH_winter);

    figure
    plot(lat, I_surf_NH);
    xlabel('lat (Deg N)');
    ylabel('Irradiance at Surface (W m^{-2})');
    title('Noon, Dec. 21');
    
    figure
    plot(lat, I_surf_SH);
    xlabel('lat (Deg N)');
    ylabel('Irradiance at Surface (W m^{-2})');
    title('Noon, Jun. 21');
end

function plot_lon_dependence()
    lat = 0;
    lon = linspace(-180, 180, 100);
    noon = datetime(2020, 3, 21, 12, 0, 0);
    six_pm = datetime(2020, 3, 21, 18, 0, 0);

    I_noon = get_surface_irradiance(lat, lon, noon);
    I_six_pm = get_surface_irradiance(lat, lon, six_pm);

    figure; hold on;
    plot(lon, I_noon, 'DisplayName', 'noon');
    plot(lon, I_six_pm, 'DisplayName', '6pm');
    xlabel('lon (Deg E)');
    ylabel('Irradiance at Surface (W m^{-2})');
    title('Noon, march 21');
    legend
    
end

function plot_map()
    lat = linspace(-90, 90, 100);
    lon = linspace(-180, 180, 100);
    NH_winter = datetime(2020, 12, 21, 12, 0, 0);
    
    [LON, LAT] = meshgrid(lon, lat);
    
    I_surf = get_surface_irradiance(LAT, LON, NH_winter);

    figure
    contour(LON, LAT, I_surf);
    xlabel('lon (deg E)');
    ylabel('lat (deg N)');
    title('Noon, Dec. 21'); 
end

function plot_seasons()
    lat = linspace(-90, 90, 100);
    lon = linspace(-180, 180, 100);
    figure; hold on;
    i=0;
    [LON, LAT] = meshgrid(lon, lat);

    while true
        dt = datetime(2020, i, 21, 12, 0, 0);

        I_surf_NH = get_surface_irradiance(LAT, LON, dt);

        contourf(LON, LAT, I_surf_NH);
        c = colorbar();
        c.Label.String = 'surface irradiance (W m^{-2})';
        xlabel('lon (deg E)');
        ylabel('lat (deg N)');
        title(sprintf('Noon, Month %d', i));
        pause(.5);
        clf('reset');
        
        i = mod(i + 1, 12);
    end
end

function plot_hours()
    lat = linspace(-90, 90, 100);
    lon = linspace(-180, 180, 100);
    figure; hold on;
    [LON, LAT] = meshgrid(lon, lat);
  
    i=0;
    while true
        dt = datetime(2020, 1, 1, i, 0, 0);

        I_surf_NH = get_surface_irradiance(LAT, LON, dt);

        contourf(LON, LAT, I_surf_NH);
        c = colorbar();
        c.Label.String = 'surface irradiance (W m^{-2})';
        xlabel('lon (deg E)');
        ylabel('lat (deg N)');
        title(datestr(dt));
        pause(0);
        clf('reset');
        
        i = i + 1;
        if mod(i, 24) == 0
            i = i + 24*20; % skip 20 days every day to see seasons
        end
    end
end