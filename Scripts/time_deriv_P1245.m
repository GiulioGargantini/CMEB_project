function dP1245dt = time_deriv_P1245(t, P1245)
%This function computes the time derivatives of P1, P2, P4 and P5 according
%to the system (1) of Art1_CMEB. 
%IOP and RLTp are assumed to be constant.
%TIME_DERIV_P1245 is to be used by ode15s
%
%INPUT: t scalar for time
%       P1245 4x1 vector of the pressures P1, P2, P4, P5.
%
%OUTPUT: dP1245dt 4x1 vector, time derivative of P1245 at time = t.

persistent data res
if isempty(data)
    data = define_constants(data);
    res = data.resistor_control_state;
end




mean_press = mean_pressures(P1245, data.Pin(t), data.Pout(t), res);
res = update_resistors(data,res, mean_press);

F = zeros(4,1); % Bloodflow in each node of P1245. It's equivalent to the
                % role of the current in the capacitance law.

% Computation of the different components of dP1245dt using Kirchhoff
% Current Law (KCL).

F(1) = (data.Pin(t) - P1245(1))./(res.Rin + res.R1a) -...
    (P1245(1) - P1245(2))./(res.R1b + res.R1c + res.R1d + res.R2a);

F(2) = (P1245(1) - P1245(2))./(res.R1b + res.R1c + res.R1d + res.R2a) -...
    (P1245(2) - P1245(3))./(res.R2b + res.R3a + res.R3b + res.R4a);

F(3) = (P1245(2) - P1245(3))./(res.R2b + res.R3a + res.R3b + res.R4a) -...
    (P1245(3) - P1245(4))./(res.R4b + res.R5a + res.R5b + res.R5c);

F(4) = (P1245(3) - P1245(4))./(res.R4b + res.R5a + res.R5b + res.R5c) -...
    (P1245(4) - data.Pout(t))./(res.R5d + res.Rout);

dP1245dt = F./(data.capacitances);

end