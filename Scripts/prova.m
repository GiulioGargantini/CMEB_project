data = [];
data = define_constants(data);
res = data.resistor_control_state;
P1245 = solve_circuit_1245(data, res, 0);
mp = mean_pressures(P1245, data.Pin(0), data.Pout(0), res);



res.R4a = starling_resistor(data.ven.SV.krrho, data.ven.SV.L, data.ven.SV.Aref,...
    (mp.R4a - data.IOP), data.ven.SV.kp, data.ven.SV.kL) / data.ven.SV.n;

res.R4b = starling_resistor(data.ven.LV.krrho, data.ven.LV.L, data.ven.LV.Aref,...
    (mp.R4b - data.IOP), data.ven.LV.kp, data.ven.LV.kL) / data.ven.LV.n;


res.R5a = starling_resistor(data.CRV.krrho, data.CRV.L_a, data.CRV.Aref,...
    (mp.R5a - data.IOP), data.CRV.kp, data.CRV.kL);

res.R5b = starling_resistor(data.CRV.krrho, data.CRV.L_b, data.CRV.Aref,...
    (mp.R5b - data.LCp), data.CRV.kp, data.CRV.kL);

fprintf('\nresistor 4a\n')
fprintf('data.ven.SV.krrho = %5.5f\n',data.ven.SV.krrho);
fprintf('data.ven.SV.L = %5.5f\n',data.ven.SV.L);
fprintf('data.ven.SV.Aref = %5.5f\n',data.ven.SV.Aref);
fprintf('deltaP = %5.5f\n',mp.R4a - data.IOP);
fprintf('data.ven.SV.kp = %5.5f\n',data.ven.SV.kp);
fprintf('data.ven.SV.kL = %5.5f\n',data.ven.SV.kL);
fprintf('data.ven.SV.n = %5.5f\n',data.ven.SV.n);
fprintf('res.R4a = %5.5f\n',res.R4a);

fprintf('\nresistor 4b\n')
fprintf('data.ven.LV.krrho = %5.5f\n',data.ven.LV.krrho);
fprintf('data.ven.LV.L = %5.5f\n',data.ven.LV.L);
fprintf('data.ven.LV.Aref = %5.5f\n',data.ven.LV.Aref);
fprintf('deltaP = %5.5f\n',mp.R4b - data.IOP);
fprintf('data.ven.LV.kp = %5.5f\n',data.ven.LV.kp);
fprintf('data.ven.LV.kL = %5.5f\n',data.ven.LV.kL);
fprintf('data.ven.LV.n = %5.5f\n',data.ven.LV.n);
fprintf('res.R4b = %5.5f\n',res.R4b);

fprintf('\nresistor 5a\n')
fprintf('data.CRV.krrho = %5.5f\n',data.CRV.krrho);
fprintf('data.CRV.L = %5.5f\n',data.CRV.L_a);
fprintf('data.CRV.Aref = %5.5f\n',data.CRV.Aref);
fprintf('deltaP = %5.5f\n',mp.R5a - data.IOP);
fprintf('data.CRV.kp = %5.5f\n',data.CRV.kp);
fprintf('data.CRV.kL = %5.5f\n',data.CRV.kL);
fprintf('data.CRV.n = %5.5f\n',1);
fprintf('res.R5a = %5.5f\n',res.R5a);
fprintf('res_ref.R5a = 5%5f\n', data.resistor_control_state.R5a)