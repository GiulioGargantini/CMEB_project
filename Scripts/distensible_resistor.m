function R = distensible_resistor(mu, L, Aref, delP, Dist, n, conversion)
%Computes the resistance of a distensible tube (venjles).
%INPUT: 1) mu = dynamic viscosity of blood and found in data
%       2) L = length of the resistor, found in data
%       3) Aref = reference cross section, computed in data using the 
%                   available parameters
%       4) delP = difference between the internal mean pressure and the 
%                   external pressure. The former is found in the computed
%                   variable struct mp, the last is in data.
%       5) Dist = distensibility, found in data
%       6) n = number of parallel vessels, parameter found in data.
%       7) conversion = conversion factor for units (from cP/mm^3 to
%                   mmHg*s/mL)
%
%OUTPUT R = value of the resistance.
%
%The formula used is built using the definition of distensibility (compliance
%C = -dV/dP, D = C/V)

R = 8 * pi * mu * L / Aref.^2 * exp(-2 * Dist * delP) / n * conversion;
end