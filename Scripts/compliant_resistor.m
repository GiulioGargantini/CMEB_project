function R = compliant_resistor(krrho, L, Aref, delP, kp, kL)
%Computes the resistance of a compliant tube (arteries).
%INPUT: 1) krrho = kr * rho specific for each resistor and found in data
%       2) L = length of the resistor, found in data
%       3) Aref = reference cross section, computed in data using the 
%                   available parameters
%       4) delP = difference between the internal mean pressure and the 
%                   external pressure. The former is found in the computed
%                   variable struct mp, the last is in data.
%       5) kp = kp parameter found in data
%       6) kL = kL parameter found in data.
%
%OUTPUT R = value of the resistance.
%
%The formula used is the one found in the notes (4.52) and in art1_CMEB (2)

    R = krrho * L /Aref^2 * (1+ delP/(kp * kL))^(-4);
    
end
