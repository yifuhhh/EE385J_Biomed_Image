function  dP = two_species(t,param,y)
% y is a 2 x 1 array.  y(1) = the IC for N, y(2) = the IC for Q
%{ 
Take these odes and write it as a system of ODES
dN/dt = param(1)*N*(1-N)  -param(2)*Q*N      

dQ/dt = param(3)*Q - param(4)*Q*N; 

%}


dP(1) = param(1)*y(1)*(1-y(1))-param(2)*y(2)*y(1);
dP(2) = param(3)*y(2)-param(4)*y(2)*y(1);
dP = dP'; % sometimes you need to transpose the results...

end