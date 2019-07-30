function P1245 = solve_circuit_1245(data, res, t)
% This function is used to solve the circuit at the initial time.
%output: P1245 4x1 vector of the corresponding pressures.

R_tot = res.Rin+res.R1a+res.R1b+res.R1c+res.R1d+res.R2a+res.R2b+res.R3a+...
    res.R3b+res.R4a+res.R4b+res.R5a+res.R5b+res.R5c+res.R5d+res.Rout;

R_in_1 = res.Rin+res.R1a;
R_1_2 = res.R1b+res.R1c+res.R1d+res.R2a;
R_2_4 = res.R2b+res.R3a+res.R3b+res.R4a;
R_4_5 = res.R4b+res.R5a+res.R5b+res.R5c;
R_5_out = res.R5d+res.Rout;

P1245 = zeros(4,1);
Pin = data.Pin(t);
Pout = data.Pout(t);
dP = Pin - Pout;


P1245(1) = dP * (R_1_2 + R_2_4 + R_4_5 + R_5_out)/R_tot + Pout;
P1245(2) = dP * (R_2_4 + R_4_5 + R_5_out)/R_tot + Pout;
P1245(3) = dP * (R_4_5 + R_5_out)/R_tot + Pout;
P1245(4) = dP * (R_5_out)/R_tot + Pout;

end