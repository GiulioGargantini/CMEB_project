function res = update_resistors(data,res,t, mp)
% This function, given the pressures P1, P2, P4 and P5, and given Pin and
% Pout through the data and the time t, updates the values of the nonlinear
% resistors in each portion in-1, 1-2, 2-4, 4-5 and 5-out.

%% Compliant tubes
res.R1c = compliant_resistor(data.CRA.krrho, data.CRA.L_c, data.CRA.Aref,...
    (mp.R1c - data.LCp),data.CRA.kp, data.CRA.kL);

res.R1d = compliant_resistor(data.CRA.krrho, data.CRA.L_d, data.CRA.Aref,...
    (mp.R1d - data.IOP),data.CRA.kp, data.CRA.kL);

%% Collapsible tubes


end
