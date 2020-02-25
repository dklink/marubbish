t = datetime(2015, 1, 1, 0, 0, 0):hours(2):datetime(2017, 1, 1, 0, 0, 0);
r_pl = .00001
p = Particle(r_pl, kooi_constants.rho_LDPE, 0, constants.NP_lat, constants.NP_lon, 0);

disp(['Salinity forcing: ' Paths.salinity]);
disp(['Temperature forcing: ' Paths.temperature]);
disp(['Surface Chlorophyll forcing: ' Paths.chlorophyll]);

%view_world_light_at_location(p.lat-60, p.lon+100, t(15));

z = get_z(t, p);

figure;
plot(t, z);
set(gca, 'ydir', 'reverse');
ylabel('depth (m)');
title(sprintf('LDPE, radius %.02f mm', r_pl*1000));