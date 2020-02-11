function respiration_rate = get_algae_respiration(particle, T)
%GET_ALGAE_RESPIRATION calculate respiration rate, Kooi 2017 eq. 11 term 4
%   particle: the particle in question
%   T: temperature at particle (Celsius)
%   return: rate of algal respiration (# algae particles m^-2 s^-1)
    Q_10 = kooi_constants.Q_10;
    R_A = kooi_constants.R_A;
    respiration_rate = R_A * Q_10.^((T-20)/10) .* particle.A;
end
