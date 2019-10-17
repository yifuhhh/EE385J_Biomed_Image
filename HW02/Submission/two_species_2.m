function  dP = two_species_2(t, param, y, Cp)
% y is a 2 x 1 array.  y(1) = the IC for CT, y(2) = the IC for CIC
%{ 
Take these odes and write it as a system of ODES
dCT/dt = param(1)*Cp - param(2)*CT - param(3)*CT

dCIC/dt = param(3)*CT

%}


dP(1) = param(1) * Cp(t) - param(2) * y(1) - param(3) * y(1);
dP(2) = param(3) * y(1);
dP = dP';

end