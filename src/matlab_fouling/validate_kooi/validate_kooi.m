%kooi fig 1
seconds_per_hour = 3600;
hours_per_week = 24*7;

NP_lat = 25.428321;   % lat and lon of spot near hawaii
NP_lon = -151.773256; %

particle_radius = .001;
p = Particle(particle_radius, kooi_constants.rho_LDPE, 0, NP_lat, NP_lon, 0);

dt_hours = .1;  % this seems to be granular enough
dt = seconds_per_hour*dt_hours;
hours = 1:dt_hours:2400;   % 100 days, time step every dt_hours
A = zeros(1, length(hours));
z = zeros(1, length(hours));

I_m = kooi_constants.I_m;
chl_surf = .05;
chl_ave = .151;
z(1) = p.z;
A(1) = p.A;
for i=2:length(hours)
    I_surf = I_vs_time(hours(i));
    T_z = T_vs_z(p.z);
    I_z = get_light_at_z(p.z, I_surf, chl_ave);
    S_z = S_vs_z(p.z);
    dAdt = get_algae_flux_for_particle(p, S_z, T_z, chl_surf, I_z);
    
    p.A = p.A + dAdt * dt;
    
    V_s = get_settling_velocity(p, S, T);
    
    p.z = p.z + V_s * dt;
    if p.z < 0  % silly particle, you can't fly
        p.z = 0;
    end
    z(i) = p.z;
    A(i) = p.A;
end

figure
plot(hours/24, A);
xlabel('days');
ylabel('algae count');
figure
plot(hours/24, z);
xlabel('days');
ylabel('depth (m)');
set(gca, 'YDir','reverse');


function I = I_vs_time(hour)
    I = kooi_constants.I_m * sin((2*pi) * hour/24);
    I(I < 0) = 0;
end

