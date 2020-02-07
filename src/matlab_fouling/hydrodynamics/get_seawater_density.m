function rho_sw = get_seawater_density(S, T, lat, lon, z)
%GET_SEAWATER_DENSITY calculated by matching kooi exactly
% S: salinity of water parcel (g / kg)
% T: temperature of water parcel (degrees C)
% lat: latitude of water parcel (degrees N)
% lon: longitude of water parcel (degrees E)
% z: depth of water parcel (m, positive down)
% return: in-situ density of water parcel (kg m^-3)
    S = S/1000;  % convert g/kg to kg/kg
    a_1 = 9.999E2;
    a_2 = 2.034E-2;
    a_3 = -6.162E-3;
    a_4 = 2.261E-5;
    a_5 = -4.657E-8;
    b_1 = 8.020E2;
    b_2 = -2.001;
    b_3 = 1.677E-2;
    b_4 = -3.060e-5;  % correct value
    %b_4 = 2.261e-5; % kooi's value
    b_5 = -1.613e-5;  % correct value
    %b_5 = -4.657e-5; %kooi's value
                    % typos cause profile which is .03 kg m^-3 more dense
                    % at surface, too small to cause problems
    rho_sw = (a_1 + a_2*T + a_3*T.^2 + a_4*T.^3 + a_5*T.^4) + ...
              (b_1*S + b_2*S.*T + b_3*S.*T.^2 + b_4*S.*T.^3 + b_5*S.^2.*T.^2);
end
