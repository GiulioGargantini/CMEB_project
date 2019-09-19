function res = update_resistors(data,res,t, mp)
% This function, given the pressures P1, P2, P4 and P5, and given Pin and
% Pout through the data and the time t, updates the values of the nonlinear
% resistors in each portion in-1, 1-2, 2-4, 4-5 and 5-out.

%% Compliant tubes
res.R1c = compliant_resistor(data.CRA.krrho, data.CRA.L_c, data.CRA.Aref,...
    (mp.R1c - data.LCp), data.CRA.kp, data.CRA.kL);

res.R1d = compliant_resistor(data.CRA.krrho, data.CRA.L_d, data.CRA.Aref,...
    (mp.R1d - data.IOP), data.CRA.kp, data.CRA.kL);

%% Collapsible tubes
res.R5a = starling_resistor(data.CRV.krrho, data.CRV.L_a, data.CRV.Aref,...
    (mp.R5a - data.IOP), data.CRV.kp, data.CRV.kL);

res.R5b = starling_resistor(data.CRV.krrho, data.CRV.L_a, data.CRV.Aref,...
    (mp.R5b - data.LCp), data.CRV.kp, data.CRV.kL);



%% Active tubes (arterioles)

if data.AR == 0
    res.R2a = data.resistor_control_state.R2a;
else
    res.R2a = active_resistor( data.resistor_control_state.R2a, data.art.cL, ...
        data.art.cU, data.art.K, data.OPP, data.Q_bar, data.art.c_hat);
end

res.R2b = res.R2a;


end
