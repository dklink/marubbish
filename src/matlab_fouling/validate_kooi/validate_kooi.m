%kooi fig 1
seconds_per_hour = 3600;
hours_per_week = 24*7;

NP_lat = 25.428321;   % lat and lon of spot near hawaii
NP_lon = -151.773256; %

particle_radius = .001;
p = Particle(particle_radius, kooi_constants.rho_LDPE, 5e12, NP_lat, NP_lon, 0);

dt_hours = .1;  % this seems to be granular enough
dt = seconds_per_hour*dt_hours;
hours = 1:dt_hours:240;   % 10 days, every dt_hours hours
A = zeros(1, length(hours));
z = zeros(1, length(hours));

I_m = kooi_constants.I_m;
chl_surf = .05;
chl_ave = .151;

for i=1:length(hours)
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

%{
% testing the temp profile
z = linspace(0, 100);
plot(T_vs_z(z), z);
set(gca, 'YDir', 'reverse');
%}

%{
%testing the salinity profile.  No mixed layer?!?
z = linspace(0, 2000);
plot(S_vs_z(z), z);
set(gca, 'YDir', 'reverse');
%}

function I = I_vs_time(hour)
    I = kooi_constants.I_m * sin((2*pi) * hour/24);
    I(I < 0) = 0;
end

function T_z = T_vs_z(z)  % eq 22
    T_surf_NP = 25;
    T_bot_NP = 1.5;
    p_NP = 2;
    z_c_NP = -300;
    T_z = T_surf_NP + (T_bot_NP - T_surf_NP)*(z.^p_NP ./ (z.^p_NP + z_c_NP^p_NP));
end

function S_z = S_vs_z(z)  %eq 24
    z = -1*z;
    z_fix_NP = -1000;
    S_fix_NP = 34.6;
    b_1_NP = 9.9979979767e-17;
    b_2_NP = 1.0536246487e-12;
    b_3_NP = 3.9968286066e-9;
    b_4_NP = 6.5411526250e-6;
    b_5_NP = 4.1954014008e-3;
    b_6_NP = 3.5172984035e1;
    S_z = b_1_NP*z.^5 + b_2_NP * z.^4 + b_3_NP*z.^3 + b_4_NP*z.^2 + b_5_NP*z + b_6_NP;
    
    S_z(z < z_fix_NP) = S_fix_NP;
end