function mortality_rate = get_algae_mortality(particle)
%GET_ALGAE_MORTALITY return rate of algae mortality due to grazing
%   Kooi 2017 eq. 11, term 3.  Kooi uses a single mortality coefficient from 
%   Calbet 2004.
%   
%   particle: the particle in question
%   return: rate of algae death due to grazing (# algae particles m^-2 s^-1)

    m_A = kooi_constants.m_A;
    mortality_rate = m_A * particle.A;
end