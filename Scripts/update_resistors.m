function res = update_resistors(data, res, mp)
% This function, given the pressures P1, P2, P4 and P5, and given Pin and
% Pout through the data and the time t, updates the values of the nonlinear
% resistors in each portion in-1, 1-2, 2-4, 4-5 and 5-out.


%% Compliant tubes
res.R1c = compliant_resistor(data.CRA.krrho, data.CRA.L_c, data.CRA.Aref,...
    (mp.R1c - data.LCp), data.CRA.kp, data.CRA.kL);

res.R1d = compliant_resistor(data.CRA.krrho, data.CRA.L_d, data.CRA.Aref,...
    (mp.R1d - data.IOP), data.CRA.kp, data.CRA.kL);

% %% Distensible tubes (NON HA SENSO!!!)
% % res.R4a = distensible_resistor(data.ven.SV.mu, data.ven.SV.L, data.ven.SV.Aref,...
% %    (mp.R4a - data.IOP), data.ven.SV.Dist, data.ven.SV.n, data.convert_MPa_to_mmHg * 1e-6);
% res.R4a = data.ven.SV.res_const;
% % 
% % res.R4b = distensible_resistor(data.ven.LV.mu, data.ven.LV.L, data.ven.LV.Aref,...
% %    (mp.R4b - data.IOP), data.ven.LV.Dist, data.ven.LV.n, data.convert_MPa_to_mmHg * 1e-6);
% res.R4b = data.ven.LV.res_const;

%% Collapsible tubes

res.R4a = starling_resistor(data.ven.krrho, data.ven.L, data.ven.Aref,...
    (mp.R4a - data.IOP), data.ven.kp, data.ven.kL);

res.R4b = starling_resistor(data.ven.krrho, data.ven.L, data.ven.Aref,...
    (mp.R4b - data.IOP), data.ven.kp, data.ven.kL);


res.R5a = starling_resistor(data.CRV.krrho, data.CRV.L_a, data.CRV.Aref,...
    (mp.R5a - data.IOP), data.CRV.kp, data.CRV.kL);

res.R5b = starling_resistor(data.CRV.krrho, data.CRV.L_b, data.CRV.Aref,...
    (mp.R5b - data.LCp), data.CRV.kp, data.CRV.kL);

%fprintf ('R5b: res.R5b = %4.4f, delP = %3.4f \n', res.R5b, (mp.R5b - data.LCp));


%% Active tubes (arterioles)

if data.AR == 0
    res.R2a = data.resistor_control_state.R2a;
else
    res.R2a = active_resistor_variante( data.resistor_control_state.R2a, data.art.cL, ...
        data.art.cU, data.art.K, data.OPP, data.Q_bar, data.art.c_hat);
end

res.R2b = res.R2a;

% mp
% res
% pause
end
