function mortality_rate = get_algae_mortality(particle)
%GET_ALGAE_MORTALITY return rate of algae mortality due to grazing
%   Kooi 2017 eq. 11, term 3.  Kooi used single mortality coefficient from 
%   Calbet 2004; Calbet offers regionally varying coefficients, and we use
%   these.
%   
%   particle: the particle in question
%   return: rate of algae death due to grazing (# algae particles s^-1)
m_A = CalbetConstants.getAlgaeMortality(particle.lat);  % algae mortality (s^-1)
mortality_rate = m_A * particle.A;
end