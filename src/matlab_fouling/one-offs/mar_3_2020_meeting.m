% create plots for presentation on march 3, 2020

%world map of average depth
% for each simulated lat, lon,
%   do a 2-year simulation.  Discard first year as spin-up.
%       average depth of second year.
% 2 year simulation takes about 2 seconds.
% if we sample earth in 1 deg, we get 360*180=64800 points.
%   this means we have a 64800*2/3600 = 36 hour simulation.
% if we sample earth in 10 deg, we get 36*18=648 points.
%   this means we have a 648*2/60 = 21.6 minute simulation.
% I need to parallelize the code on the particle level anyways.  But
% perhaps I don't have to do this before this presentation.

lon_grid = linspace(-180, 180, 18);
lat_grid = linspace(-90, 90, 18);
summer = zeros(length(lon_grid), length(lat_grid));
fall = zeros(length(lon_grid), length(lat_grid));
winter = zeros(length(lon_grid), length(lat_grid));
spring = zeros(length(lon_grid), length(lat_grid));
for lon_idx=1:length(lon_grid)
    for lat_idx=1:length(lat_grid)
        nchar = fprintf("%.1f percent done", ((lon_idx-1)*length(lat_grid) + lat_idx) / (length(lat_grid)*length(lon_grid)) * 100);
        p = Particle(.0001, kooi_constants.rho_PP, 0, lat_grid(lat_idx), lon_grid(lon_idx), 0);
        [z_summer, z_fall, z_winter, z_spring] = get_z_ave(p);
        summer(lon_idx, lat_idx) = z_summer;
        fall(lon_idx, lat_idx) = z_fall;
        winter(lon_idx, lat_idx) = z_winter;
        spring(lon_idx, lat_idx) = z_spring;
        fprintf(repmat('\b', 1, nchar));  % matlab doesn't have carriage returns (ugh)
    end
end

save('last_run.mat', 'p', 'lon_grid', 'lat_grid', 'summer', 'fall', 'winter', 'spring')

m_proj('mercator');
[lon, lat] = m_ll2xy(lon_grid, lat_grid);
[LAT, LON] = meshgrid(lat, lon);
contourf(LON, LAT, spring)
m_coast();

function [summer, fall, winter, spring] = get_z_ave(p)
% do a 2-year simulation of particle vertical dynamics.
% Discard first year as spin-up, return average depth of each season of
% second year.  Skips time taken to begin settling.
    % p: the particle, whose properties determine lat, lon, density
    % returns: [summer, fall, winter, spring], all time-average depths (m)
    
    t = datetime(2015, 1, 1, 0, 0, 0):hours(.25*pi):datetime(2017, 1, 1, 0, 0, 0);
    p.update_particle_from_rho_tot(1024);  % start just when particle beginning to sink
    
    [z, ~] = get_z(t, p);
    if isnan(z)
        summer = nan;
        fall = nan;
        winter = nan;
        spring = nan;
        return;
    end
    
    z = z(year(t) == 2016);
    t = t(year(t) == 2016);
    mo = month(t);
    summer = mean(z(ismember(mo, [6,7,8])));
    fall = mean(z(ismember(mo, [9,10,11])));
    winter = mean(z(ismember(mo, [12,1,2])));
    spring = mean(z(ismember(mo, [3,4,5])));
end