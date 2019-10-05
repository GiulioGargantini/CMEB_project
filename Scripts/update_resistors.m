function res = update_resistors(data, res, mp)
% This function, given the pressures P1, P2, P4 and P5, and given Pin and
% Pout through the data and the time t, updates the values of the nonlinear
% resistors in each portion in-1, 1-2, 2-4, 4-5 and 5-out.


%% Compliant tubes

% res.R1c = compliant_resistor_var(data.resistor_control_state.R1c,...
%     (mp.R1c - data.LCp), data.CRA.kp, data.CRA.kL);
% 
% res.R1d = compliant_resistor_var(data.resistor_control_state.R1d,...
%     (mp.R1d - data.IOP), data.CRA.kp, data.CRA.kL);

res.R1c = compliant_resistor(data.CRA.krrho, data.CRA.L_c, data.CRA.Aref,...
    (mp.R1c - data.LCp), data.CRA.kp, data.CRA.kL);

res.R1d = compliant_resistor(data.CRA.krrho, data.CRA.L_d, data.CRA.Aref,...
    (mp.R1d - data.IOP), data.CRA.kp, data.CRA.kL);


%% Collapsible tubes

res.R4a = starling_resistor_var(data.resistor_control_state.R4a,...
    (mp.R4a - data.IOP), data.ven.kp, data.ven.kL);

res.R4b = starling_resistor_var(data.resistor_control_state.R4b,...
    (mp.R4b - data.IOP), data.ven.kp, data.ven.kL);


% res.R5a = starling_resistor_var(data.resistor_control_state.R5a,...
%     (mp.R5a - data.IOP), data.CRV.kp, data.CRV.kL);
% 
% res.R5b = starling_resistor_var(data.resistor_control_state.R5b,...
%     (mp.R5b - data.LCp), data.CRV.kp, data.CRV.kL);

% res.R4a = starling_resistor(data.ven.krrho, data.ven.L, data.ven.Aref,...
%     (mp.R4a - data.IOP), data.ven.kp, data.ven.kL);
% 
% res.R4b = starling_resistor(data.ven.krrho, data.ven.L, data.ven.Aref,...
%     (mp.R4b - data.IOP), data.ven.kp, data.ven.kL);
% 
% 
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
