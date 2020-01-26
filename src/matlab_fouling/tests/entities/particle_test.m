r_microplastic = .001; % m
rho_LDPE = 930; % kg m^-3
some_algae = 1e6;

p_no_algae = Particle(r_microplastic, rho_LDPE, 0, 0, 0, 0);
p_yes_algae = Particle(r_microplastic, rho_LDPE, some_algae, 0, 0, 0);

test_theta_pl(p_no_algae, r_microplastic);

test_V_bf(p_no_algae, 0);
test_V_bf(p_yes_algae, some_algae);

test_V_pl(p_no_algae, r_microplastic);

test_V_tot(p_no_algae);
test_V_tot(p_yes_algae);

test_r_tot(p_no_algae);
test_r_tot(p_yes_algae);

test_t_bf(p_no_algae);
test_t_bf(p_yes_algae);

test_rho_tot(p_no_algae);
test_rho_tot(p_yes_algae);

disp("All Tests Passed");

function test_theta_pl(particle, r_pl)
    assert(particle.theta_pl() == 4 * pi * r_pl^2);
end

function test_V_bf(particle, A)
    assert(particle.V_bf() == kooi_constants.V_A * A);
end

function test_V_pl(particle, r_pl)
    assert(particle.V_pl() == 4/3 * pi * r_pl^3);
end

function test_V_tot(particle)
    assert(particle.V_tot() == particle.V_pl() + particle.V_bf())
end

function test_r_tot(particle)
    assert(particle.r_tot() == nthroot(3/(4*pi) * particle.V_tot(), 3));
end

function test_t_bf(particle)
    assert(particle.t_bf() == particle.r_tot() - particle.r_pl);
end

function test_rho_tot(particle)
    A = particle.rho_tot();
    B = (particle.r_pl^3 * particle.rho_pl + ...
          ((particle.r_pl + particle.t_bf)^3 - particle.r_pl^3)*particle.rho_bf) ...
            / (particle.r_pl + particle.t_bf)^3;
 
    assert(abs(A-B) < 1e4*eps(min(abs(A),abs(B))));  % floating point disagreement
end