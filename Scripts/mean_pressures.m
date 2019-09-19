function mp = mean_pressures(P1245, Pin, Pout, res)
%This function returns a struct with the values of the mean pressures
%in the resistors of the circuit. Such values are found thanks to
%Kirchhoff Voltage Law.
%In this version, only the mean pressures of variable resistors are computed.

mp.R1c = P1245(2) + (P1245(1) - P1245(2)) * (res.R1c/2 + res.R1d + res.R2a) /...
    (res.R1b + res.R1c + res.R1d + res.R2a);

mp.R1d = P1245(2) + (P1245(1) - P1245(2)) * (res.R1d/2 + res.R2a) /...
    (res.R1b + res.R1c + res.R1d + res.R2a);

mp.R2a = P1245(2) + (P1245(1) - P1245(2)) * (res.R2a/2) /...
    (res.R1b + res.R1c + res.R1d + res.R2a);

mp.R2b = P1245(3) + (P1245(2) - P1245(3)) * (res.R2b/2 + res.R3a + res.R3b + res.R4a) /...
    (res.R2b + res.R3a + res.R3b + res.R4a);
 
mp.R4a = P1245(3) + (P1245(2) - P1245(3)) * (res.R4a/2) /...
    (res.R2b + res.R3a + res.R3b + res.R4a);

mp.R4b = P1245(4) + (P1245(3) - P1245(4)) * (res.R4b/2 + res.R5a + res.R5b + res.R5c) /...
    (res.R4b + res.R5a + res.R5b + res.R5c);

mp.R5a = P1245(4) + (P1245(3) - P1245(4)) * (res.R5a/2 + res.R5b + res.R5c) /...
    (res.R4b + res.R5a + res.R5b + res.R5c);

mp.R5b = P1245(4) + (P1245(3) - P1245(4)) * (res.R5b/2 + res.R5c) /...
    (res.R4b + res.R5a + res.R5b + res.R5c);

end