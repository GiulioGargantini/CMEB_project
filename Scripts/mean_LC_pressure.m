function P = mean_LC_pressure(data)
%Computes the average value of the external pressure in the Lamina Cribrosa
%segment.

Plc = @(x) LC_pressure(x, data.IOP, data.RLTp);
f = @(x) (1 + (Plc(x) - data.P_LC_art)./(data.CRA.kp * data.CRA.kL)).^(-4);
integ = integral(f, -data.CRA.L_c/2, data.CRA.L_c/2);

P = ((integ / data.CRA.L_c)^(-1/4) - 1) * data.CRA.kp * data.CRA.kL + data.P_LC_art;
end